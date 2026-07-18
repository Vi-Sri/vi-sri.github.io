(function () {
  "use strict";

  const banner = document.querySelector("[data-analytics-consent]");
  if (!banner) return;

  const measurementId = banner.dataset.measurementId;
  const preferenceKey = "vi-sri-analytics-consent";

  function loadAnalytics() {
    if (!measurementId || window.gtag) return;

    window.dataLayer = window.dataLayer || [];
    window.gtag = function () { window.dataLayer.push(arguments); };
    window.gtag("js", new Date());
    window.gtag("config", measurementId, {
      allow_google_signals: false,
      allow_ad_personalization_signals: false
    });

    const script = document.createElement("script");
    script.async = true;
    script.src = `https://www.googletagmanager.com/gtag/js?id=${encodeURIComponent(measurementId)}`;
    document.head.append(script);
  }

  window.trackSiteEvent = function (name, parameters) {
    if (window.gtag) window.gtag("event", name, parameters || {});
  };

  let preference = null;
  try { preference = window.localStorage.getItem(preferenceKey); } catch (_) { /* Storage can be unavailable. */ }

  if (preference === "accepted") {
    loadAnalytics();
    return;
  }

  if (preference !== "rejected") banner.hidden = false;

  banner.querySelector("[data-analytics-accept]").addEventListener("click", function () {
    try { window.localStorage.setItem(preferenceKey, "accepted"); } catch (_) { /* Continue for this page. */ }
    banner.hidden = true;
    loadAnalytics();
  });

  banner.querySelector("[data-analytics-reject]").addEventListener("click", function () {
    try { window.localStorage.setItem(preferenceKey, "rejected"); } catch (_) { /* Continue for this page. */ }
    banner.hidden = true;
  });
})();
