export const validateEmail = (email) => {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return re.test(email);
};

export const validateName = (name) => {
  return name && name.trim().length > 0 && name.trim().length <= 100;
};

export default { validateEmail, validateName };
