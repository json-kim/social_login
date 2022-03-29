const functions = require("firebase-functions");
const admin = require("firebase-admin");

// admin.initializeApp();
var serviceAccount = require("./appfirebase-656ab-firebase-adminsdk-6slkz-7b0bf38821.json");
const { user } = require("firebase-functions/v1/auth");
const { provider } = require("firebase-functions/v1/analytics");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://appfirebase-656ab-de46f.firebaseio.com"
});

// 카카오 로그인 리디렉트 함수
exports.kakaologin = functions.https.onRequest((request, response) => {
  functions.logger.info(request.query.code);
  response.redirect(`kakaologincallback://success?code=${request.query.code}`);
});

// 카카오 로그아웃 리디렉트 함수
exports.kakaologout = functions.https.onRequest((request, response) => {
  
});


// 카카오 커스텀 토큰 생성 함수
exports.createCustomTokenKakao = functions.https.onRequest(async (request, response) => {
  const user = request.body;

  const userRecord = await updateOrCreateUser(user);
  await admin.auth().setCustomUserClaims(userRecord.uid, { kakaoUID: 'kakao test id', provider: "kakao.com" });

  const customToken = await admin.auth().createCustomToken(userRecord.uid, { kakaoUID: 'kakao test id', provider: "kakao.com" });
  response.send(customToken);
});

// 네이버 커스텀 토큰 생성 함수
exports.createCustomTokenNaver = functions.https.onRequest(async (request, response) => {
  const user = request.body;

  const userRecord = await updateOrCreateUser(user);
  await admin.auth().setCustomUserClaims(userRecord.uid, { kakaoUID: 'naver test id', provider: "naver.com" });

  const customToken = await admin.auth().createCustomToken(userRecord.uid, { kakaoUID: 'kakao test id', provider: "kakao.com" });
  response.send(customToken);
});

// 새로운 유저를 생성하거나 동일한 email이 있다면 기존 유저의 정보(이름, 프로필 이미지) 업데이트해서 유저 정보 리턴
async function updateOrCreateUser(userParams) {
	try {
		var userRecord = await admin.auth().getUserByEmail(userParams['email']);
    return admin.auth().updateUser(userRecord.uid, userParams);
	} catch (error) {
		if (error.code === 'auth/user-not-found') {
			return admin.auth().createUser(userParams);
		}
		throw error;
	}
}