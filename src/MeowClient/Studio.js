
import { Studio } from "meowclient";
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

let toClass = value => new Studio(value.session, value.id)

export let apiImpl = ok => err => studio =>
    catch_(v => ok(objToCamelCase(v)), err, toClass(studio).getAPIData())

export let followImpl = ok => err => studio =>
    catch_(ok, err, toClass(studio).follow())

export let unfollowImpl = ok => err => studio =>
    catch_(ok, err, toClass(studio).unfollow())

export let setTitleImpl = ok => err => value => studio =>
    catch_(ok, err, toClass(studio).setTitle(value))

export let setDescriptionImpl = ok => err => value => studio =>
    catch_(ok, err, toClass(studio).setDescription(value))

export let inviteCuratorImpl = ok => err => name => studio =>
    catch_(ok, err, toClass(studio).inviteCurator(name))

export let removeCuratorImpl = ok => err => name => studio =>
    catch_(ok, err, toClass(studio).removeCurator(name))

export let acceptInviteImpl = ok => err => studio =>
    catch_(ok, err, toClass(studio).acceptInvite())

export let myStatusImpl = ok => err => studio =>
    catch_(ok, err, toClass(studio).getUserData())

export let addProjectImpl = ok => err => id => studio =>
    catch_(ok, err, toClass(studio).addProject(id))

export let removeProjectImpl = ok => err => id => studio =>
    catch_(ok, err, toClass(studio).removeProject(id))

export let commentImpl = ok => err => content => parentId => commenteeId => studio =>
    catch_(ok, err, toClass(studio).comment(content, parentId, commenteeId))

export let toggleCommentingImpl = ok => err => studio =>
    catch_(ok, err, toClass(studio).toggleComments())

export let getCuratorsImpl = ok => err => limit => offset => studio =>
    catch_(v => ok(v.map(objToCamelCase)), err, toClass(studio).getCurators(limit, offset))

export let getManagersImpl = ok => err => limit => offset => studio =>
    catch_(v => ok(v.map(objToCamelCase)), err, toClass(studio).getManagers(limit, offset))

export let getProjectsImpl = ok => err => limit => offset => studio =>
    catch_(v => ok(v.map(objToCamelCase)), err, toClass(studio).getProjects(limit, offset))
