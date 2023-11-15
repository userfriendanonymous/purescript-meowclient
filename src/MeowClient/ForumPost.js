import { Post } from "meowclient";
import { objectKeysToCamelCaseV2 as objToCamelCase } from 'keys-converter'

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

let toClass = value => new Post(value.session, value.id)

export let infoImpl = ok => err => post =>
    catchP(ok, err, async () => {
        let cl = toClass(post)
        await cl.setData()
        return cl.data
    })

export let sourceImpl = ok => err => post =>
    catchP(ok, err, () => toClass(post).getSource())

export let editImpl = ok => err => content => post =>
    catchP(ok, err, () => toClass(post).edit(content))
    