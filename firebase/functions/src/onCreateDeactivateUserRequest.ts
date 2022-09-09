import * as admin from 'firebase-admin'
import * as functions from 'firebase-functions'

export const onCreateDeactivateUserRequest = functions
    .region(`asia-northeast1`)
    .firestore.document(`/deactivateUserRequests/{deactivateUserRequestId}`)
    .onCreate(async (snapshot, context) => {
        const data = snapshot.data()
        const uid = data.uid
        try {
            await admin.auth().updateUser(uid,{
                disabled: true
            })
        } catch (e) {
            functions.logger.info(`アカウント停止失敗 ${uid}`)
        }
    })