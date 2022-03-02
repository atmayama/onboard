const cuid = require("cuid");
const express = require("express");

const app = express()




const users = {}, ref = {};
app.use(express.urlencoded());
app.use(express.json());

app.use((req, res, next) => {
    console.log(req.headers, req.method, req.url, req.body, req.query);
    next();
});


app.post("/v1/referral/generateOtp", ({ body: { phoneNumber } }, res) => {
    console.log(phoneNumber);
    if (ref[phoneNumber])
        res.json({ otpToken: "", existingUser: true })
    else {
        const token = cuid();
        ref[token] = phoneNumber;
        console.log(token)
        res.json({ otpToken: token, existingUser: false })
    }
});

app.post("/v1/referral/verifyOtp", ({ body: { otpToken, otp } }, res) => {
    console.log(otpToken, otp)
    if (otp === "123456") {
        const userId = cuid();
        users[userId] = {
            id: userId,
            phoneNumber: ref[otpToken],
            verified: true
        }
        console.log(userId);
        res.json({ status: "success", userId })
    }
    else res.status(400).send({ error: "invalid otp" });
});

app.get("/v1/user", ({ query: { id } }, res) => {
    console.log(id);
    if (users[id]) {
        res.json(users[id]);
    }
    else res.status(400).send({ error: "invalid otp" });
});


app.listen(8080, () => { console.log("running") });