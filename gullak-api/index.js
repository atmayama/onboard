const cuid = require("cuid");
const express = require("express");

const app = express()

app.use(express.json());


const users = {

}

app.post("/v1/referral/generateOtp", ({ body: { phoneNumber } }, res) => {
    if (users[phoneNumber])
        res.json({ otpToken: "", existingUser: true })
    else {
        users[phoneNumber] = { token: cuid() }
        res.json({ otpToken: users[phoneNumber].token, existingUser: false })
    }
});

app.post("/v1/referral/verifyOtp", ({ body: { otpToken, otp } }, res) => {

    if (otp === "123456") res.json({ status: "success" })
    else res.status(400).send({ error: "invalid otp" });
});

app.listen(8080, () => { console.log("running") });