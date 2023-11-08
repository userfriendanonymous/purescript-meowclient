import { Post } from "meowclient";
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

let toClass = value => new Post(value.session, value.id)

export let infoImpl = ok => err => post =>
    catch_(ok, err,
        (async () => {
            let cl = toClass(post)
            cl.setData()
            return cl.data
        })()
    )

export let sourceImpl = ok => err => post =>
    catch_(ok, err, toClass(post).getSource())

export let editImpl = ok => err => content => post =>
    catch_(ok, err, toClass(post).edit(content))
    