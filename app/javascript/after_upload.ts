document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("upload-form") as HTMLFormElement;
  const submitBtn = document.getElementById("upload-btn");
  const spinner = document.getElementById("spinner");
  const page = document.getElementById("uploader") as HTMLFormElement;

  if (!form || !submitBtn || !spinner) return;

  form.addEventListener("submit", (e) => {
    e.preventDefault(); 
    document.body.style.opacity = "0.4";
    spinner.classList.remove("d-none");
    
    const blocker = document.createElement("div");
    blocker.classList.remove("d-none");
    blocker.classList.add("ui-blocker");
    blocker.id = "ui-blocker";
    document.body.appendChild(blocker);

    setTimeout(() => {
      form.submit();
    }, 3000);
  });
});
