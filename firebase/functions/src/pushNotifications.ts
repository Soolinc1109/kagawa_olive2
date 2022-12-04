import { messaging , firestore } from 'firebase-admin';
import * as functions from 'firebase-functions'

export const sendPushNotification = async (userId: string, title: string, body: string) =>{
    const db = firestore()
    const tokensSnapshot = await db.collection('users').doc(userId).collection('').get()
    const tokens = tokensSnapshot.docs.map(doc => doc.id)
    functions.logger.info(`トークン取得完了${tokens}`)
    const ms = messaging()
    functions.logger.info(`送信`)
    await ms.sendAll(tokens.map(token => ({
        token: token,
        notification:{
            title: title,
            body: body,
        }
    })))
}

export const onCreateVisitUser = functions
    .region(`asia-northeast1`)
    .firestore.document(`/shops/{shopId}/visit_user/{visitUserId}`)
    .onCreate(async (snapshot, context) => {
        functions.logger.info(`onCreateVisitUser関数発火`)
        const data = snapshot.data()
        const userId = data.user_id
        const title = '通知が来ました'
        const body = 'PR依頼'
        try {
            await sendPushNotification(userId, title, body)
        } catch (e) {
            functions.logger.error(`通知送信失敗 ${e} ${userId}`)
        }
    })