'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "c98974b3a35edeb253723d364bbdc250",
"manifest.json": "d81d47e48c65b6d6b9cd3f2326333f70",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "4a50294436cf9b7acf1459706e82fcd9",
"assets/web/manifest.json": "d81d47e48c65b6d6b9cd3f2326333f70",
"assets/web/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/web/index.html": "5d5731d1c4d223c05a98ce5d9bdc19bd",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "509ae636cfdd93e49b5a6eaf0f06d79f",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/assets/images/gas_refilling.jpeg": "d38e2115c6c13da0120588c7d4ae1c48",
"assets/assets/images/home_cleaning.jpeg": "8e1c65bf29f196b4d8a5d2c70b8c6128",
"assets/assets/images/ac_installation.jpeg": "d9d056d1cb743a331d168fc4c62fdf50",
"assets/assets/images/tv_repair.jpeg": "50434b142b1f887cd05cf4e00b4fb1ad",
"assets/assets/images/exterior_painting.jpeg": "86d1dd366932810cbe00daeb6a423afb",
"assets/assets/images/gardening.jpeg": "7e757b0a6c9a5b36fcb92a969c0bf22b",
"assets/assets/images/sofa_cleaning.jpeg": "4bbeb9914de872e077c07d68fca6ce41",
"assets/assets/images/washing_repair.jpeg": "85d96da3fee68eeb9155efaef4767787",
"assets/assets/images/interior_painting.jpeg": "c29c9a77f244cfbbde6a678c30184606",
"assets/assets/images/switchboard_repair.jpeg": "567178d8aaccea1a3f9b3169f8f2bb5f",
"assets/assets/images/cockroach_control.jpeg": "7206e67254db1e90fc46cdb357f3e169",
"assets/assets/images/ac_repair.jpeg": "11fae4ab27ea10136abfee57bdc238f8",
"assets/assets/images/wiring_installation.jpeg": "ce2313ce49cf645585968d0058730c98",
"assets/assets/images/car_cleaning.jpeg": "4db80d994b13d9632813af9ec169a621",
"assets/assets/images/bedbug_treatment.jpeg": "3b09658e6fb94af57af7699f519925a0",
"assets/assets/images/home_assitant.jpeg": "1e78f8a0f269d99fcf7c968fefb04337",
"assets/assets/images/home_cleaning.jpg": "24f5703dad0c02019dbff96a35c473b7",
"assets/assets/images/carpentary.jpeg": "9c685d7e9e789c150c936669452f05b1",
"assets/assets/icons/electrician.png": "0e20318fa82c53ddfe53730ac71a4f8d",
"assets/assets/icons/home_assist.png": "d7b2dfc9e95349144fdd695fc5b92dd6",
"assets/assets/icons/ac_services.png": "95eed13e8e4fa133247e039ff15f8151",
"assets/assets/icons/pest_control.png": "2c74066886617da80e54320da98fd572",
"assets/assets/icons/cleaning_services.png": "7d81bd28415129c2bf4f7584315d8b13",
"assets/assets/icons/painting_services.png": "1e279867f0fa3d25768042b1f108e324",
"assets/assets/icons/leaf.png": "15d1fdfcd11c06f93b0cc4e3a5d1c151",
"assets/assets/icons/appliance_repair.png": "94d024f955e281b6ae6b97a1dec31d5b",
"assets/assets/fonts/Poppins/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/fonts/Poppins/Poppins-Italic.ttf": "c1034239929f4651cc17d09ed3a28c69",
"assets/assets/fonts/Poppins/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/assets/fonts/Poppins/Poppins-Light.ttf": "fcc40ae9a542d001971e53eaed948410",
"assets/FontManifest.json": "80ce1001bbd4171ebbf29560640ff476",
"assets/AssetManifest.bin": "5df1bff599618b4f9836450e107f53a0",
"assets/AssetManifest.json": "0b3f5fd2fbfb231192d1387fae4fb8ff",
"assets/fonts/MaterialIcons-Regular.otf": "bae89a6dfb1636da6c49be22010ecb7e",
"assets/NOTICES": "bf50a6d61203a979afe0f94da5723303",
"version.json": "1791d44e9a6dda3f9eb5b7788b937bb3",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "5d5731d1c4d223c05a98ce5d9bdc19bd",
"/": "5d5731d1c4d223c05a98ce5d9bdc19bd",
"flutter_bootstrap.js": "8be1163f015d649beb32ffc19b07659c",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
