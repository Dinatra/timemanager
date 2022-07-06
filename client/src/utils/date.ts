export const formatTime = (milliseconds: number): string => {
  const date = new Date(0);
  date.setSeconds(milliseconds / 1000);
  const utc = date.toUTCString();
  return utc.substr(utc.indexOf(":") - 2, 8);
};

export const formatDate = (date: Date): string => {
  return new Date(date).toLocaleString();
};
