// Load environment variables dari file .env
require("dotenv").config();

const {setGlobalOptions} = require("firebase-functions");
const {onCall, onRequest} = require("firebase-functions/v2/https");
const axios = require("axios");
const admin = require("firebase-admin");

// Init Firebase Admin sekali
if (!admin.apps.length) {
  admin.initializeApp();
}

// Maksimal 10 container untuk fungsi ini
setGlobalOptions({maxInstances: 10});

// Ambil API key dari environment
const NANO_BANANA_API_KEY = process.env.NANO_BANANA_API_KEY || "";
const CALLBACK_URL = process.env.CALLBACK_URL || "";


/**
 * =====================================================
 *  1️⃣  FUNCTION: generateImages (dipanggil dari Flutter)
 * =====================================================
 */
exports.generateImages = onCall(async (req) => {
  const {imageUrl, prompt} = req.data;

  if (!imageUrl || !prompt) {
    throw new Error("imageUrl and prompt are required");
  }

  console.log("generateImages called with:", imageUrl, prompt);

  try {
    const body = {
      prompt: prompt,
      numImages: 3,
      type: "IMAGETOIAMGE",
      image_size: "1:1",
      imageUrls: [imageUrl],
      callbackUrl: CALLBACK_URL,
    };

    const response = await axios.post(
        "https://api.nanobananaapi.ai/api/v1/nanobanana/generate",
        body,
        {
          headers: {
            "Authorization": "Bearer " + NANO_BANANA_API_KEY,
            "Content-Type": "application/json",
          },
        },
    );

    console.log("NanoBanana API response:", response.data);

    // Cek images tanpa optional chaining
    const hasImages =
            response.data &&
            response.data.data &&
            Array.isArray(response.data.data.images);

    if (hasImages && response.data.data.images.length > 0) {
      return {
        status: "completed",
        images: response.data.data.images,
      };
    }

    // Ambil taskId
    const taskId =
            response.data &&
                response.data.data &&
                response.data.data.taskId ?
                response.data.data.taskId :
                null;

    if (!taskId) {
      throw new Error("Missing taskId from NanoBanana API");
    }

    return {
      status: "processing",
      taskId: taskId,
    };
  } catch (err) {
    const errMsg =
            err.response && err.response.data ? err.response.data : err.message;

    console.error("Error calling NanoBanana API:", errMsg);

    throw new Error("Failed to generate images");
  }
});


/**
 * =====================================================
 *  2️⃣  FUNCTION: nanobananaCallback (dipanggil oleh NanoBanana!)
 * =====================================================
 */
exports.nanobananaCallback = onRequest(
    {region: "us-central1", invoker: "public"},
    async (req, res) => {
      const rawBody = req.rawBody ? req.rawBody.toString("utf8") : "";
      let body;

      try {
        body = req.body && Object.keys(req.body).length ?
                req.body :
                JSON.parse(rawBody);
        console.log("nanobananaCallback parsed body:", body);
      } catch (e) {
        console.error("Failed to parse body:", e, "Raw body:", rawBody);
        return res.status(400).json({error: "Invalid body"});
      }

      const taskId = body.taskId || (body.data && body.data.taskId);
      if (!taskId) {
        console.warn("Missing taskId in callback");
        return res.status(400).json({error: "Missing taskId"});
      }

      // Ambil semua images jika tersedia
      let images = [];
      if (body.data && Array.isArray(body.data.images) &&
            body.data.images.length > 0) {
        images = body.data.images;
        console.log(`Received ${images.length} images from body.data.images`);
      } else if (body.data && body.data.info && body.data.info.resultImageUrl) {
        images = [body.data.info.resultImageUrl];
        console.log("Received single image from body.data.info.resultImageUrl");
      } else {
        console.warn("No images found in callback");
      }

      const status = body.status || "completed";
      const prompt = body.prompt || null;

      try {
        // Gunakan arrayUnion untuk append
        // multiple images tanpa menimpa sebelumnya
        await admin.firestore().collection("nanobanana_results")
            .doc(taskId)
            .set({
              taskId,
              images: images.length > 0 ?
                        admin.firestore.FieldValue.arrayUnion(...images) : [],
              status,
              prompt,
              updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            }, {merge: true});

        console.log(`Updated Firestore document for taskId 
                ${taskId} with ${images.length} images`);
        return res.status(200).json({success: true});
      } catch (err) {
        console.error("Error saving to Firestore:", err);
        return res.status(500).json({error: "Internal server error"});
      }
    },
);
