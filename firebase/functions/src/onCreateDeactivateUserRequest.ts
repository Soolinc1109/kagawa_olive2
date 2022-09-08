import * as admin from 'firebase-admin'
import * as functions from 'firebase-functions'

export const onCreateDeactivateUserRequest = functions
    .region(`asia-northeast1`)
    .firestore.document(`/deactivateUserRequests/{deactivateUserRequestId}`)
    .onCreate(async (snapshot, context) => {
        functions.logger.info(`あいう`)
        const data = snapshot.data()
        const documentId = context.params.deactivateUserRequestId
        const count = data.count
        functions.logger.info(`${count}`)
        await admin.firestore().collection('deactivateUserRequests').doc(documentId).update({
            'count': count + 4
        })
    })