import { Topic } from "meowclient";
import { objectKeysToCamelCaseV2 as objToCamelCase } from 'keys-converter'

let catch_ = (ok, err, promise) => async () => {
    try {
        return ok(await promise)
    } catch(e) {
        if (!(e instanceof Error)) {
            throw new Error("Error must be an instance of Error")
        }
        return err(e)
    }
}

let toClass = value => new Topic(value.session, value.id)

export let infoImpl = ok => err => forum =>
    catch_(v => ok(objToCamelCase(v)), err,
        (async () => {
            let cl = toClass(forum)
            cl.setData()
            return cl.data
        })()
    )

export let postsImpl = ok => err => page => forum =>
    catch_(v => ok(objToCamelCase(v)), err,
        (async () => {
            let cl = toClass(forum)
            cl.setData()
            return cl.data
        })()
    )
