const runWithDelay = function({ callbackFunction }) {
  run({
    callbackFunction: function() {
      setTimeout(() => {
        callbackFunction();
      }, 0);
    }
  });
};

const runAsap = function({ callbackFunction }) {
  runWithDelay({ callbackFunction: callbackFunction, delay: 0 });
};

// if already fired run callback immediately
// otherwise wait for DOM to finish loading
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

// Debounce
// source: https://gist.github.com/nmsdvid/8807205
const debounceEvent = (callback, time = 250, interval) => (...args) =>
  clearTimeout(interval, (interval = setTimeout(callback, time, ...args)));

function searchBarInit() {
  const formInput = document.querySelector(FORM_INPUT_ID);
  const debouncedCallback = debounceEvent(updateInputCallback, 40);
  ["change", "keyup", "paste", "input"].forEach(function(eventName) {
    formInput.addEventListener(eventName, updateInputCallback);
  });
}

function init() {
  runAsap({ callbackFunction: searchBarInit });
}

init();
