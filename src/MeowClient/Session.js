import { ScratchSession, Forum } from 'meowclient'
import { objectKeysToCamelCaseV2 as objToCamelCase } from 'keys-converter'

export let anonymous = new ScratchSession()

let catchP = (ok, err, f) => async () => {
    try {
        return ok(await f())
    } catch(e) {
        if (!(e instanceof Error)) {
            throw new Error("Error must be an instance of Error")
        }
        return err(e)
    }
}

export let authImpl = just => nothing => session => {
    if (session.auth) {
        return just(session.auth)
    } else {
        return nothing
    }
}

export let logInImpl = ok => err => user => pass => 
    catchP(ok, err, async () => {
        let session = new ScratchSession()
        await session.init(user, pass)
        return session
    })

export let uploadToAssetsImpl = ok => err => buffer => fileExtension => session =>
    catchP(ok, err, () => session.uploadToAssets(buffer, fileExtension))

export let searchProjectsImpl = ok => err => mode => offset => limit => query => session =>
    catchP(v => ok(v.map(objToCamelCase)), err, () => session.searchProjects(query, limit, offset, mode))

export let messagesImpl = ok => err => offset => limit => session =>
    catchP(v => ok(v.map(objToCamelCase)), err, () => session.getMessages(limit, offset))

export let logOutImpl = ok => err => session =>
    catchP(ok, err, async () => {
        let newSession = new ScratchSession()
        newSession.auth = structuredClone(session.auth)
        await newSession.logout()
    })

export let setSignatureImpl = ok => err => content => session =>
    catchP(ok, err, () => new Forum(session, 0).setSignature(content))
