import { Topic } from "meowclient";
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

let toClass = value => new Topic(value.session, value.id)

export let infoImpl = ok => err => topic =>
    catchP(v => ok(objToCamelCase(v)), err, async () => {
        let cl = toClass(topic)
        await cl.setData()
        return cl.data
    })

export let postsImpl = ok => err => tuple => page => topic =>
    catchP(v => ok(v.map(objToCamelCase)), err, async () => 
        (await toClass(topic).getPosts(page))
            .map(v => tuple(v.id)(v.data))
    )

export let replyImpl = ok => err => content => topic =>
    catchP(ok, err, () => toClass(topic).reply(content))

export let followImpl = ok => err => topic =>
    catchP(ok, err, () => toClass(topic).follow())

export let unfollowImpl = ok => err => topic =>
    catchP(ok, err, () => toClass(topic).unfollow())
    