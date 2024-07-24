document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price');
  const taxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  if (priceInput && taxPrice && profit) {
    priceInput.addEventListener('input', () => {
      const price = parseInt(priceInput.value, 10);

      if (!isNaN(price) && price > 0) {
        const fee = Math.floor(price * 0.1);
        const earnings = Math.floor(price - fee);
        taxPrice.textContent = fee;
        profit.textContent = earnings;
      } else {
        taxPrice.textContent = '';
        profit.textContent = '';
      }
    });
  }
});
