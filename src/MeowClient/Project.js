import { Project } from "meowclient";
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

let toClass = value => new Project(value.session, value.id)

export let apiImpl = ok => err => project =>
    catchP(v => ok(objToCamelCase(v)), err, () => toClass(project).getAPIData())

export let commentsImpl = ok => err => offset => limit => project =>
    catchP(v => ok(v.map(objToCamelCase)), err, () => toClass(project).getComments(offset, limit))

export let commentRepliesImpl = ok => err => offset => limit => id => project =>
    catchP(v => ok(v.map(objToCamelCase)), err, () => toClass(project).getCommentReplies(id, offset, limit))

export let sendCommentImpl = ok => err => commenteeId => parentId => content => project =>
    catchP(ok, err, () => toClass(project).comment(content, parentId, commenteeId))

export let setCommentingImpl = ok => err => allowed => project =>
    catchP(ok, err, () => toClass(project).setCommentsAllowed(allowed))

export let setTitleImpl = ok => err => value => project =>
    catchP(ok, err, () => toClass(project).setTitle(value))

export let setInstructionsImpl = ok => err => value => project =>
    catchP(ok, err, () => toClass(project).setInstructions(value))

export let setNotesAndCreditsImpl = ok => err => value => project =>
    catchP(ok, err, () => toClass(project).setNotesAndCredits(value))

export let setThumbnailImpl = ok => err => buffer => project =>
    catchP(ok, err, () => toClass(project).setThumbnail(buffer))

export let shareImpl = ok => err => project =>
    catchP(ok, err, () => toClass(project).share())

export let unshareImpl = ok => err => project =>
    catchP(ok, err, () => toClass(project).unshare())

export let isLovingImpl = ok => err => project =>
    catchP(ok, err, () => toClass(project).isLoving())

export let isFavoritingImpl = ok => err => project =>
    catchP(ok, err, () => toClass(project).isFavoriting())

export let setLovingImpl = ok => err => value => project =>
    catchP(ok, err, () => toClass(project).setLoving(value))

export let setFavoritingImpl = ok => err => value => project =>
    catchP(ok, err, () => toClass(project).setFavoriting(value))
