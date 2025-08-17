module.exports = {
    config_id: "development",
    port: process.env.PORT || 8080,
    mongo_uri: process.env.MONGO_URI || "mongodb://localhost:27017/ead_db"
};