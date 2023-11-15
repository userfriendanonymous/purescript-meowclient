import { CloudConnection } from "meowclient";
import { objectKeysToCamelCaseV2 as objToCamelCase } from 'keys-converter'

let catch_ = (ok, err, f) => () => {
    try {
        return ok(f())
    } catch(e) {
        if (!(e instanceof Error)) {
            throw new Error("Error must be an instance of Error")
        }
        return err(e)
    }
}

export let initImpl = ok => err => id => session =>
    catch_(ok, err, () => new CloudConnection(session, id))

export let session = socket => socket.session

export let id = socket => socket.id

export let setVarImpl = ok => err => name => value => socket =>
    catch_(ok, err, () => socket.setVariable(name, value))

export let varImpl = ok => err => name => socket =>
    catch_(ok, err, () => socket.getVariable(name))

export let closeImpl = ok => err => socket =>
    catch_(ok, err, () => socket.close())
