import { Forum } from "meowclient";
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

let toClass = value => new Forum(value.session, value.id)

export let topicsImpl = ok => err => page => forum =>
    catchP(v => ok(objToCamelCase(v)), err, () => toClass(forum).getTopics(page))

export let createTopicImpl = ok => err => title => body => forum =>
    catchP(ok, err, () => toClass(forum).createTopic(title, body))
    
export let setSignatureImpl = ok => err => content => forum =>
    catchP(ok, err, () => toClass(forum).setSignature(content))
