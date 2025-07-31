document.addEventListener("DOMContentLoaded", () => {
  const links = document.querySelectorAll(".sortable-column");

  links.forEach(link => {
    link.addEventListener("click", async (e) => {
      e.preventDefault();

      const column = link.getAttribute("data-sort-column");
      const order = link.getAttribute("data-sort-order") || "asc";
      const column_type = link.getAttribute("data-column-type");
      
      if (column_type === "association"){
        let association = (column === "locations") ? "locations" : "affiliations";
        let headerElement = document.getElementsByClassName(association);
        document.querySelectorAll("." + association).forEach((element) => {
          let kids = Array.from(element.children);
          if (kids.length <= 1) return;

          kids.sort((a, b) => {
            return a.textContent!.localeCompare(b.textContent!, undefined, { sensitivity: 'base' });
          });
          if(order === "desc"){kids.reverse();}
          kids.forEach(child => element.appendChild(child));
        });
      }else
      {
        let url = `/main_view.json?sort_by=${column}&order=${order}`;
        const response = await fetch(url);
        if (response.ok) {
          const data = await response.json();
          const tbody = document.getElementById("people-table-body");
          if (tbody){
          tbody.innerHTML = data.html;
          }
        }
      }
      const arrow = link.querySelector("span#sort-arrow");
      if (arrow) {
        arrow.textContent = order === "asc" ? "⬇️" : "⬆️";
      }

      link.setAttribute("data-sort-order", order === "asc" ? "desc" : "asc");
    });
  });
});
