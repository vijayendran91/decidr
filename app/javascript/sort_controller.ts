document.addEventListener("DOMContentLoaded", () => {
  const links = document.querySelectorAll(".sortable-column");

  links.forEach(link => {
    link.addEventListener("click", async (e) => {
      e.preventDefault();

      const column = link.getAttribute("data-sort-column");
      const order = link.getAttribute("data-sort-order") || "asc";

      const url = `/main_view.json?sort_by=${column}&order=${order}`;
      const response = await fetch(url);

      if (response.ok) {
        const data = await response.json();
        const tbody = document.getElementById("people-table-body");
        if (tbody){
         tbody.innerHTML = data.html;
        }

        const arrow = link.querySelector("span#sort-arrow");
        if (arrow) {
          arrow.textContent = order === "asc" ? "⬇️" : "⬆️";
        }

        link.setAttribute("data-sort-order", order === "asc" ? "desc" : "asc");
      }
    });
  });
});
