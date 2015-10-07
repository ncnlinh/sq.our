export default {
  isAlphaNumeric: (str) => {
    const alphaNumRegex = /^[a-zA-Z0-9-_]+$/;
    return alphaNumRegex.test(str);
  },
  isNumeric: (str) => {
    const numRegex = /^[0-9]+$/;
    return numRegex.test(str);
  }
};
