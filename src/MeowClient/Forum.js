import { Forum } from "meowclient";
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

let toClass = value => new Forum(value.session, value.id)

export let topicsImpl = ok => err => page => forum =>
    catch_(v => ok(objToCamelCase(v)), err, toClass(forum).getTopics(page))

export let createTopicImpl = ok => err => title => body => forum =>
    catch_(ok, err, toClass(forum).createTopic(title, body))
    
export let setSignatureImpl = ok => err => content => forum =>
    catch_(ok, err, toClass(forum).setSignature(content))
