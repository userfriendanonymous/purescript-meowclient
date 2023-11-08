import { Profile } from "meowclient";
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

let toClass = value => new Profile(value.session, value.username)

export let statusImpl = ok => err => profile =>
    catch_(ok, err, toClass(profile).getStatus())

export let followImpl = ok => err => profile =>
    catch_(ok, err, toClass(profile).follow())

export let unfollowImpl = ok => err => profile =>
    catch_(ok, err, toClass(profile).unfollow())

export let commentImpl = ok => err => content => parentId => commenteeId => profile =>
    catch_(ok, err, toClass(profile).comment(content, parentId, commenteeId))
    
export let deleteCommentImpl = ok => err => id => profile =>
    catch_(ok, err, toClass(profile).deleteComment(id))

export let apiImpl = ok => err => profile =>
    catch_(v => ok(objToCamelCase(v)), err, toClass(profile).getUserAPI())

export let messagesCountImpl = ok => err => profile =>
    catch_(ok, err, toClass(profile).getMessageCount())

export let commentsImpl = ok => err => page => profile =>
    catch_(v => ok(v.map(objToCamelCase)), err, toClass(profile).getComments(page))

export let toggleCommentsImpl = ok => err => profile =>
    catch_(ok, err, toClass(profile).toggleComments())
