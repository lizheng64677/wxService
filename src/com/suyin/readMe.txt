
Attention: 这里的所有东西唯一的作用就是稍微处理一下前台的请求，转化为inService服务需要的参数格式，然后发给inService。
一些方法的命名规则：由于jsp页面放在web-inf中，所有进入页面先要请求一下controller，这些请求都是 toXXX的格式

com.suyin.userCenter 处理个人中心的所有请求，包括登录和注册。 这里大部分的请求都是需要获取用户openid的。

com.suyin.find 处理 发现这个tab下的所有请求，包括广告，主题，折扣，帖子什么的

com.suyin.index 处理首页这个tab的所有请求。

com.suyin.sensitive 处理所有敏感操作，这里只是操作。（比如进入活动详情页，这个任何人都能够进入，这就不是敏感操作）

几乎所有请求都会经过VerificationHandlerInterceptor过滤一下,以保证session中一定有openid

敏感操作都必须经过SensitiveHandlerInterceptor过滤，以保证该用户注册过了