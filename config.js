// Simulating a developer accidentally committing credentials
// This is a FAKE secret used only to test that Kingfisher catches it

const config = {
  db: {
    host: "localhost",
    port: 5432,
  },
  aws: {
    accessKeyId: "AKIAIOSFODNN7EXAMPLE",
    secretAccessKey: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
    region: "us-east-1",
  },
};

module.exports = config;
