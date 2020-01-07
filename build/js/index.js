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

function setProjectVisibility({ project, visible }) {
  const parentCategory = project.closest(".category");

  if (visible) {
    parentCategory.classList.remove("hide");
  } else {
    parentCategory.classList.add("hide");
  }
}

const FORM_INPUT_ID = "input#search-query";
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

// Debounce any function with specified interval.
// source: https://gist.github.com/nmsdvid/8807205
const debounceEvent = (callback, time = 250, interval) => (...args) =>
  clearTimeout(interval, (interval = setTimeout(callback, time, ...args)));

function searchBarInit() {
  const formInput = document.querySelector(FORM_INPUT_ID);
  const debouncedCallback = debounceEvent(updateInputCallback, 20);
  ["change", "keyup", "paste", "input"].forEach(function(eventName) {
    formInput.addEventListener(eventName, debouncedCallback);
  });
}

// The form is only used to filter results as the user types.
// There is no server-side component to submit to.
function preventFormSubmit() {
  const form = document.querySelector("form");
  form.addEventListener("submit", event => {
    event.preventDefault();
    return false;
  });
}

// Setup a click handler for the sun/moon icon to toggle night mode.
function toggleNightModeInit() {
  const toggleElem = document.querySelector("#toggle-night-mode");
  toggleElem.addEventListener("click", event => {});
}

function init() {
  runAsap({ callbackFunction: searchBarInit });
  runAsap({ callbackFunction: toggleNightModeInit });
  runAsap({ callbackFunction: preventFormSubmit });
}
init();
