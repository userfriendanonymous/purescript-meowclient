import { ScratchSession } from 'meowclient'
import { objectKeysToCamelCaseV2 as objToCamelCase } from 'keys-converter'

export let value = new ScratchSession()

let catchAsString = (ok, err, promise) => async () => {
    try {
        return ok(await promise)
    } catch(e) {
        if (!(e instanceof Error)) {
            throw new Error("Error must be an instance of Error")
        }
        return err(e.message)
    }
}

export let initImpl = ok => err => user => pass => 
    catchAsString(ok, err, (async () => {
        let session = new ScratchSession()
        await session.init(user, pass)
        return session
    })())

export let uploadToAssetsImpl = ok => err => buffer => fileExtension => session =>
    catchAsString(ok, err, session.uploadToAssets(buffer, fileExtension))

export let searchProjectsImpl = ok => err => query => limit => offset => mode => session =>
    catchAsString(v => ok(v.map(objToCamelCase)), err, session.searchProjects(query, limit, offset, mode))

export let getMessagesImpl = tuple => ok => err => limit => offset => session =>
    catchAsString(v => ok(v.map(i => tuple(i.type)(objToCamelCase(i)))), err, session.getMessages(limit, offset))

export let logoutImpl = ok => err => session =>
    catchAsString(ok, err, structuredClone(session).logout())
