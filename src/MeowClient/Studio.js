
import { Studio } from "meowclient";
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

let toClass = value => new Studio(value.session, value.id)

export let apiImpl = ok => err => studio =>
    catchP(v => ok(objToCamelCase(v)), err, () => toClass(studio).getAPIData())

export let followImpl = ok => err => studio =>
    catchP(ok, err, () => toClass(studio).follow())

export let unfollowImpl = ok => err => studio =>
    catchP(ok, err, () => toClass(studio).unfollow())

export let setTitleImpl = ok => err => value => studio =>
    catchP(ok, err, () => toClass(studio).setTitle(value))

export let setDescriptionImpl = ok => err => value => studio =>
    catchP(ok, err, () => toClass(studio).setDescription(value))

export let inviteCuratorImpl = ok => err => name => studio =>
    catchP(ok, err, () => toClass(studio).inviteCurator(name))

export let removeCuratorImpl = ok => err => name => studio =>
    catchP(ok, err, () => toClass(studio).removeCurator(name))

export let acceptInviteImpl = ok => err => studio =>
    catchP(ok, err, () => toClass(studio).acceptInvite())

export let myStatusImpl = ok => err => studio =>
    catchP(ok, err, () => toClass(studio).getUserData())

export let addProjectImpl = ok => err => id => studio =>
    catchP(ok, err, () => toClass(studio).addProject(id))

export let removeProjectImpl = ok => err => id => studio =>
    catchP(ok, err, () => toClass(studio).removeProject(id))

export let sendCommentImpl = ok => err => commenteeId => parentId => content => studio =>
    catchP(ok, err, () => toClass(studio).comment(content, parentId, commenteeId))

export let toggleCommentingImpl = ok => err => studio =>
    catchP(ok, err, () => toClass(studio).toggleComments())

export let curatorsImpl = ok => err => offset => limit => studio =>
    catchP(v => ok(v.map(objToCamelCase)), err, () => toClass(studio).getCurators(limit, offset))

export let managersImpl = ok => err => offset => limit => studio =>
    catchP(v => ok(v.map(objToCamelCase)), err, () => toClass(studio).getManagers(limit, offset))

export let projectsImpl = ok => err => offset => limit => studio =>
    catchP(v => ok(v.map(objToCamelCase)), err, () => toClass(studio).getProjects(limit, offset))
