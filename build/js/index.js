//////////////////////////////
// DOM READY CALLBACKS
//////////////////////////////
// Run function once DOM is ready.
// Works with async loaded scripts.
const runWithDelay = function({ callbackFunction }) {
  run({
    callbackFunction: function() {
      setTimeout(() => {
        callbackFunction();
      }, 0);
    }
  });
};
// Run function on a delay after DOM is ready.
// Works with async loaded scripts.
const runAsap = function({ callbackFunction }) {
  runWithDelay({ callbackFunction: callbackFunction, delay: 0 });
};
const runManyAsap = function({ callbackFunctions }) {
  callbackFunctions.forEach(f => {
    runAsap({ callbackFunction: f });
  });
};
// If already fired run callback immediately
// otherwise wait for DOM to finish loading.
// source: https://stackoverflow.com/a/50026257
function run({ callbackFunction }) {
  if (
    document.readyState === "interactive" ||
    document.readyState === "complete"
  ) {
    callbackFunction();
  } else if (document.addEventListener) {
    document.addEventListener("DOMContentLoaded", callbackFunction());
  } else if (document.attachEvent) {
    document.attachEvent("onreadystatechange", function() {
      if (document.readyState != "loading") {
        callbackFunction();
      }
    });
  }
}

// SHOW/HIDE ENTRIES
function setProjectVisibility({ project, visible }) {
  const parentCategory = project.closest(".category");

  if (visible) {
    parentCategory.classList.remove("hide");
  } else {
    parentCategory.classList.add("hide");
  }
}

// SEARCH BAR UPDATE
const SELECTOR_ENTRIES = ".category .entry";
function updateInputCallback(event) {
  const query = event.target.value.toLowerCase().trim();
  const projects = document.querySelectorAll(SELECTOR_ENTRIES);

  if (query === "") {
    projects.forEach(function(project) {
      setProjectVisibility({ project: project, visible: true });
    });
  } else {
    projects.forEach(function(project) {
      setProjectVisibility({ project: project, visible: false });
    });

    const searchProjects = document.querySelectorAll(
      '[data-search*="' + query + '"]'
    );
    searchProjects.forEach(function(project) {
      setProjectVisibility({ project: project, visible: true });
    });
  }
}

// DEBOUNCE
// Debounce any function with specified interval.
// source: https://gist.github.com/nmsdvid/8807205
const debounceEvent = (callback, time = 250, interval) => (...args) =>
  clearTimeout(interval, (interval = setTimeout(callback, time, ...args)));

// SEARCH BAR INIT
const FORM_INPUT_ID = "input#search-query";
function searchBarInit() {
  const formInput = document.querySelector(FORM_INPUT_ID);
  const debouncedCallback = debounceEvent(updateInputCallback, 20);
  ["change", "keyup", "paste", "input"].forEach(function(eventName) {
    formInput.addEventListener(eventName, debouncedCallback);
  });
}

// PREVENT FORM SUBMIT
// The form is only used to filter results as the user types.
// There is no server-side component to submit to.
function preventFormSubmit() {
  const form = document.querySelector("form");
  form.addEventListener("submit", event => {
    event.preventDefault();
    return false;
  });
}

// DARK MODE USER SETTING
// local storage is used to override OS theme settings
const LOCAL_STORAGE_KEY_DARK_MODE_SETTING = "dark-mode-setting";
const USER_SETTING_DARK_MODE_SETTING_DARK = "dark";
const USER_SETTING_DARK_MODE_SETTING_LIGHT = "light";
function getDarkModeUserSetting() {
  return localStorage.getItem(LOCAL_STORAGE_KEY_DARK_MODE_SETTING);
}
function setDarkModeUserSetting({ isDark }) {
  const val = isDark
    ? USER_SETTING_DARK_MODE_SETTING_DARK
    : USER_SETTING_DARK_MODE_SETTING_LIGHT;
  return localStorage.setItem(LOCAL_STORAGE_KEY_DARK_MODE_SETTING, val);
}

// DARK MODE OS SETTING
function getOsDarkModeSetting() {
  return window.matchMedia
    ? window.matchMedia("(prefers-color-scheme: dark)").matches
    : false; // matchMedia method not supported
}

// DARK MODE CURRENT
// Current dark mode setting.
// User setting if available, otherwise default to OS.
function isDarkMode() {
  return getDarkModeUserSetting()
    ? getDarkModeUserSetting() == USER_SETTING_DARK_MODE_SETTING_DARK
    : getOsDarkModeSetting();
}

// DARK MODE DOM SETTING
const DOM_ATTR_NAME_DARK_MODE = "data-dark-mode-theme";
const DOM_ATTR_DARK_MODE_DARK = "dark";
const DOM_ATTR_DARK_MODE_LIGHT = "light";
function setDomDarkModeSetting({ isDark }) {
  const val = isDark ? DOM_ATTR_DARK_MODE_DARK : DOM_ATTR_DARK_MODE_LIGHT;
  document.documentElement.setAttribute(DOM_ATTR_NAME_DARK_MODE, val);
}
function getDomDarkModeSetting() {
  return document.documentElement.getAttribute(DOM_ATTR_NAME_DARK_MODE);
}

// DARK MODE TOGGLE ELEMENT
const DOM_SELECTOR_DARK_MODE_TOGGLE = "#toggle-night-mode";
function darkModeToggleElem() {
  return document.querySelector(DOM_SELECTOR_DARK_MODE_TOGGLE);
}

// DARK MODE ICON IMG
const DOM_SELECTOR_DARK_MODE_ICON_IMG = "#toggle-night-mode img";
function darkModeIconImg() {
  return document.querySelector(DOM_SELECTOR_DARK_MODE_ICON_IMG);
}
// DARK MODE ICON
const DARK_MODE_ICON_IMG_PATH_DARK = "img/moon.png";
const DARK_MODE_ICON_IMG_PATH_LIGHT = "img/sun.png";
function setDarkModeIcon({ isDark }) {
  // it's opposite what you'd expect,
  // because we should the icon for what
  // the new dark mode WOULD change to
  // if the user clicked it
  const newVal = isDark
    ? DARK_MODE_ICON_IMG_PATH_LIGHT
    : DARK_MODE_ICON_IMG_PATH_DARK;

  darkModeIconImg().setAttribute("src", newVal);
}

// TOGGLE DARK MODE
// Changes the theme and sets a localStorage variable
// to track the theme between page loads
function toggleDarkMode() {
  const newIsDark = !isDarkMode();
  setDarkModeUserSetting({ isDark: newIsDark });
  setDomDarkModeSetting({ isDark: newIsDark });
  setDarkModeIcon({ isDark: newIsDark });
}
// DARK MODE CLICK INIT
function darkModeClickCallbackSetup() {
  // click handler for the sun/moon icon to toggle night mode
  darkModeToggleElem().addEventListener("click", event => {
    toggleDarkMode();
    event.preventDefault();
    return false;
  });
}
// DARK MODE DOM INIT
function initDarkModeDomSetting() {
  setDomDarkModeSetting({ isDark: isDarkMode() });
}
// DARK MODE USER SETTING INIT
function initDarkModeUserSetting() {
  setDarkModeUserSetting({ isDark: isDarkMode() });
}
function initDarkModeIcon() {
  setDarkModeIcon({ isDark: isDarkMode() });
}

// DARK MODE INIT
function initDarkMode() {
  initDarkModeUserSetting();
  initDarkModeIcon();
  initDarkModeDomSetting();
  darkModeClickCallbackSetup();
}

// INIT
function init() {
  runManyAsap({
    callbackFunctions: [searchBarInit, initDarkMode, preventFormSubmit]
  });
}
init();
