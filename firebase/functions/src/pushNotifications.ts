import { messaging , firestore } from 'firebase-admin';

export const sendePushNotification = async (userId: string, title: string, body: string) =>{
    const db = firestore()
    const tokensSnapshot = await db.collection('shops').doc(userId).collection('tokens').get()
    const tokens = tokensSnapshot.docs.map(doc => doc.id)

    const ms = messaging()
    await ms.sendAll(tokens.map(token => ({
        token: token,
        notification:{
            title: title,
            body: body,
        }
    })))
}

export const resisterTokensToTopic = async (token: string,topic:string) => {
    const ms = messaging()
    return ms.subscribeToTopic(token,topic)
}


export const sendPushNotificationToTopic = async (topic:string,body:string) => {
    const ms = messaging()
    await ms.sendToTopic(topic, {
        notification: {
            body:body,
        }
    })
}


import * as admin from 'firebase-admin'
import * as functions from 'firebase-functions'
import { topic } from 'firebase-functions/v1/pubsub';

export const pushNotifications = functions
    .region(`asia-northeast1`)
    .firestore.document(`/visit_user/{deactivateUserRequestId}`)
    .onCreate(async (snapshot, context) => {
        const options = {
            priority: "high",
          };
        
        const token = "FCMToken";
        const payload = {
          notification: {
            title: "プッシュタイトル",
            body: "内容",
            badge: "1",             //バッジ数  
            sound:"default"         //プッシュ通知音
          }
        };
        const data = snapshot.data()
        const uid = data.uid
        try {
            await admin.messaging().sendToDevice(token, payload, options)
        } catch (e) {
            functions.logger.info(`push通知失敗 ${uid}`)
        }
    })

