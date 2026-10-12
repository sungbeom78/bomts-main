(() => {
  const slides = [...document.querySelectorAll(".slide")];
  const previousButton = document.querySelector("#previous");
  const nextButton = document.querySelector("#next");
  const fullscreenButton = document.querySelector("#fullscreen");
  const counter = document.querySelector("#counter");
  const progress = document.querySelector("#progress");
  let currentIndex = 0;
  let touchStartX = 0;

  const indexFromHash = () => {
    const requested = Number.parseInt(window.location.hash.slice(1), 10);
    return Number.isInteger(requested) && requested >= 1 && requested <= slides.length
      ? requested - 1
      : 0;
  };

  const showSlide = (index, updateHash = true) => {
    currentIndex = Math.max(0, Math.min(index, slides.length - 1));
    slides.forEach((slide, slideIndex) => {
      const active = slideIndex === currentIndex;
      slide.classList.toggle("is-active", active);
      slide.setAttribute("aria-hidden", String(!active));
    });
    counter.value = `${currentIndex + 1} / ${slides.length}`;
    counter.textContent = counter.value;
    progress.style.width = `${((currentIndex + 1) / slides.length) * 100}%`;
    previousButton.disabled = currentIndex === 0;
    nextButton.disabled = currentIndex === slides.length - 1;
    document.title = `${slides[currentIndex].querySelector("h1").textContent} | BOMTS 강의 자료`;
    if (updateHash) history.replaceState(null, "", `#${currentIndex + 1}`);
  };

  const move = (step) => showSlide(currentIndex + step);

  previousButton.addEventListener("click", () => move(-1));
  nextButton.addEventListener("click", () => move(1));

  fullscreenButton.addEventListener("click", async () => {
    if (document.fullscreenElement) {
      await document.exitFullscreen();
    } else {
      await document.documentElement.requestFullscreen();
    }
  });

  document.addEventListener("keydown", (event) => {
    if (["ArrowRight", "PageDown", " "].includes(event.key)) {
      event.preventDefault();
      move(1);
    } else if (["ArrowLeft", "PageUp"].includes(event.key)) {
      event.preventDefault();
      move(-1);
    } else if (event.key === "Home") {
      showSlide(0);
    } else if (event.key === "End") {
      showSlide(slides.length - 1);
    }
  });

  document.addEventListener("click", (event) => {
    if (event.target.closest("a, button")) return;
    move(event.clientX < window.innerWidth / 2 ? -1 : 1);
  });

  document.addEventListener("touchstart", (event) => {
    touchStartX = event.changedTouches[0].clientX;
  }, { passive: true });

  document.addEventListener("touchend", (event) => {
    const distance = event.changedTouches[0].clientX - touchStartX;
    if (Math.abs(distance) >= 50) move(distance < 0 ? 1 : -1);
  }, { passive: true });

  window.addEventListener("hashchange", () => showSlide(indexFromHash(), false));
  showSlide(indexFromHash(), false);
})();
