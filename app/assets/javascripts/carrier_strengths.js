document.addEventListener("DOMContentLoaded", () => {
  const inputs = [...document.querySelectorAll("[name='carrier[specialties]']")];
  const correctInputs = inputs.map(company => company.value);
  const alert = document.querySelector('.strengthsAlert');

  const handleChange = (e) => {
    const currentInputs = Array.from(new Set(inputs.map(company => company.value)));
    const missingInputs = correctInputs.filter(input => !currentInputs.includes(input)).map(input => `「${input}」`).join('、');
    if(currentInputs.length < 5) {
      alert.style.opacity = 1;
      alert.textContent = `同じ項目を複数選択することはできませんので、${missingInputs}を振り分けてください。`
    } else {
      alert.style.opacity = 0;
    }
  }

  inputs.forEach(strength => strength.addEventListener('change', handleChange));
});