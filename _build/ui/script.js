// Funkcja, która może zostać wywołana, by zmienić status na stronie
function updateStatus() {
    const statusElement = document.querySelector("section p");
    statusElement.textContent = "Pi-hole jest w trakcie aktualizacji... Proszę czekać.";
}

// Wywołanie funkcji po załadowaniu strony
window.onload = function() {
    updateStatus();
};
