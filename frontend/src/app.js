async function fetchStatus() {
  try {
    const res = await fetch("/api/status");
    const data = await res.json();
    document.getElementById("status").textContent = `Statut API : ${data.status}`;
  } catch (e) {
    document.getElementById("status").textContent = "Erreur de connexion à l'API";
  }
}

async function fetchItems() {
  try {
    const res = await fetch("/api/items");
    const data = await res.json();
    const list = document.getElementById("items");
    list.innerHTML = "";
    data.forEach((item) => {
      const li = document.createElement("li");
      li.textContent = `${item.id} - ${item.label}`;
      list.appendChild(li);
    });
  } catch (e) {
    const list = document.getElementById("items");
    list.innerHTML = "<li>Impossible de récupérer les items</li>";
  }
}

fetchStatus();
fetchItems();
