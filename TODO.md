# TODO

These TODOs are to be resolved by the developer, NOT THE LLM.

## Before Each Release

- upgrade all and check security issues in github
- update docs to describe the changes

## Today

2026-05-11 23:31:26,157 ERROR [dev.abs.cer.ser.ContactService] (executor-thread-1) [skey:] Failed to send contact notification email for submission from ant.kutschera@gmail.com: java.util.concurrent.CompletionException: io.netty.channel.AbstractChannel$AnnotatedConnectException: Connection refused: mail.maxant.ch/127.0.0.1:587
	at io.smallrye.mutiny.operators.uni.UniBlockingAwait.await(UniBlockingAwait.java:84)
	at io.smallrye.mutiny.groups.UniAwait.atMost(UniAwait.java:76)
	at io.quarkus.mailer.runtime.BlockingMailerImpl.send(BlockingMailerImpl.java:29)
	at dev.abstratium.certification.service.ContactService.sendNotificationEmail(ContactService.java:58)
	at dev.abstratium.certification.service.ContactService.submit(ContactService.java:34)
	at dev.abstratium.certification.service.ContactService_Subclass.submit$$superforward(Unknown Source)
	at dev.abstratium.certification.service.ContactService_Subclass$1.apply(Unknown Source)
	at io.quarkus.arc.impl.AroundInvokeInvocationContext.proceed(AroundInvokeInvocationContext.java:73)
	at io.quarkus.arc.impl.AroundInvokeInvocationContext.proceed(AroundInvokeInvocationContext.java:62)
	at io.quarkus.narayana.jta.runtime.interceptor.TransactionalInterceptorBase.invokeInOurTx(TransactionalInterceptorBase.java:136)
	at io.quarkus.narayana.jta.runtime.interceptor.TransactionalInterceptorBase.invokeInOurTx(TransactionalInterceptorBase.java:107)
	at io.quarkus.narayana.jta.runtime.interceptor.TransactionalInterceptorRequired.doIntercept(TransactionalInterceptorRequired.java:38)
	at io.quarkus.narayana.jta.runtime.interceptor.TransactionalInterceptorBase.intercept(TransactionalInterceptorBase.java:61)
	at io.quarkus.narayana.jta.runtime.interceptor.TransactionalInterceptorRequired.intercept(TransactionalInterceptorRequired.java:32)
	at io.quarkus.narayana.jta.runtime.interceptor.TransactionalInterceptorRequired_Bean.intercept(Unknown Source)
	at io.quarkus.arc.impl.InterceptorInvocation.invoke(InterceptorInvocation.java:42)
	at io.quarkus.arc.impl.AroundInvokeInvocationContext.perform(AroundInvokeInvocationContext.java:30)
	at io.quarkus.arc.impl.InvocationContexts.performAroundInvoke(InvocationContexts.java:27)
	at dev.abstratium.certification.service.ContactService_Subclass.submit(Unknown Source)
	at dev.abstratium.certification.service.ContactService_ClientProxy.submit(Unknown Source)
	at dev.abstratium.certification.boundary.publik.ContactResource.submit(ContactResource.java:48)
	at dev.abstratium.certification.boundary.publik.ContactResource_Subclass.submit$$superforward(Unknown Source)
	at dev.abstratium.certification.boundary.publik.ContactResource_Subclass$0.apply(Unknown Source)
	at io.quarkus.arc.impl.AroundInvokeInvocationContext.proceed(AroundInvokeInvocationContext.java:73)
	at io.quarkus.arc.impl.AroundInvokeInvocationContext$NextAroundInvokeInvocationContext.proceed(AroundInvokeInvocationContext.java:97)
	at io.quarkus.hibernate.validator.runtime.interceptor.AbstractMethodValidationInterceptor.validateMethodInvocation(AbstractMethodValidationInterceptor.java:73)
	at io.quarkus.hibernate.validator.runtime.jaxrs.ResteasyReactiveEndPointValidationInterceptor.validateMethodInvocation(ResteasyReactiveEndPointValidationInterceptor.java:21)
	at io.quarkus.hibernate.validator.runtime.jaxrs.ResteasyReactiveEndPointValidationInterceptor_Bean.intercept(Unknown Source)
	at io.quarkus.arc.impl.InterceptorInvocation.invoke(InterceptorInvocation.java:42)
	at io.quarkus.arc.impl.AroundInvokeInvocationContext.proceed(AroundInvokeInvocationContext.java:70)
	at io.quarkus.arc.impl.AroundInvokeInvocationContext.proceed(AroundInvokeInvocationContext.java:62)
	at dev.abstratium.core.RateLimitInterceptor.rateLimit(RateLimitInterceptor.java:82)
	at dev.abstratium.core.RateLimitInterceptor_Bean.intercept(Unknown Source)
	at io.quarkus.arc.impl.InterceptorInvocation.invoke(InterceptorInvocation.java:42)
	at io.quarkus.arc.impl.AroundInvokeInvocationContext.perform(AroundInvokeInvocationContext.java:30)
	at io.quarkus.arc.impl.InvocationContexts.performAroundInvoke(InvocationContexts.java:27)
	at dev.abstratium.certification.boundary.publik.ContactResource_Subclass.submit(Unknown Source)
	at dev.abstratium.certification.boundary.publik.ContactResource$quarkusrestinvoker$submit_802e13587383b725261b173228ae1ad7237a7501.invoke(Unknown Source)
	at org.jboss.resteasy.reactive.server.handlers.InvocationHandler.handle(InvocationHandler.java:29)
	at io.quarkus.resteasy.reactive.server.runtime.QuarkusResteasyReactiveRequestContext.invokeHandler(QuarkusResteasyReactiveRequestContext.java:190)
	at org.jboss.resteasy.reactive.common.core.AbstractResteasyReactiveContext.run(AbstractResteasyReactiveContext.java:147)
	at io.quarkus.vertx.core.runtime.VertxCoreRecorder$15.runWith(VertxCoreRecorder.java:666)
	at org.jboss.threads.EnhancedQueueExecutor$Task.doRunWith(EnhancedQueueExecutor.java:2651)
	at org.jboss.threads.EnhancedQueueExecutor$Task.run(EnhancedQueueExecutor.java:2630)
	at org.jboss.threads.EnhancedQueueExecutor.runThreadBody(EnhancedQueueExecutor.java:1622)
	at org.jboss.threads.EnhancedQueueExecutor$ThreadBody.run(EnhancedQueueExecutor.java:1589)
	at org.jboss.threads.DelegatingRunnable.run(DelegatingRunnable.java:11)
	at org.jboss.threads.ThreadLocalResettingRunnable.run(ThreadLocalResettingRunnable.java:11)
	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
	at java.base@25.0.3/java.lang.Thread.runWith(Thread.java:1487)
	at java.base@25.0.3/java.lang.Thread.run(Thread.java:1474)
	at org.graalvm.nativeimage.builder/com.oracle.svm.core.thread.PlatformThreads.threadStartRoutine(PlatformThreads.java:832)
	at org.graalvm.nativeimage.builder/com.oracle.svm.core.thread.PlatformThreads.threadStartRoutine(PlatformThreads.java:808)
Caused by: io.netty.channel.AbstractChannel$AnnotatedConnectException: Connection refused: mail.maxant.ch/127.0.0.1:587
Caused by: java.net.ConnectException: Connection refused
	at java.base@25.0.3/sun.nio.ch.Net.pollConnect(Native Method)
	at java.base@25.0.3/sun.nio.ch.Net.pollConnectNow(Net.java:639)
	at java.base@25.0.3/sun.nio.ch.SocketChannelImpl.finishConnect(SocketChannelImpl.java:1046)
	at io.netty.channel.socket.nio.NioSocketChannel.doFinishConnect(NioSocketChannel.java:336)
	at io.netty.channel.nio.AbstractNioChannel$AbstractNioUnsafe.finishConnect(AbstractNioChannel.java:339)
	at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:784)
	at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:732)
	at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:658)
	at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:562)
	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:998)
	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
	at java.base@25.0.3/java.lang.Thread.runWith(Thread.java:1487)
	at java.base@25.0.3/java.lang.Thread.run(Thread.java:1474)
	at org.graalvm.nativeimage.builder/com.oracle.svm.core.thread.PlatformThreads.threadStartRoutine(PlatformThreads.java:832)
	at org.graalvm.nativeimage.builder/com.oracle.svm.core.thread.PlatformThreads.threadStartRoutine(PlatformThreads.java:808)




- consolidate sql scripts
- simplify the overviews, they're too long
- make fonts friendlier
- certification on setting up and deploying abstrauth
- send email when feedback is submitted
- let users provide thumbs up for certification / show how many people have the certification
- RateLimitState needs a max size otherwise we will get a memory problem and it can remove ips after a timeout
- move core.IpAddressUtil into abstracore
- move core.RateLimiting into abstracore
- make wizard in core more abstract
- user needs to add the user to the right groups so that they can upload files to the server (var/www and etc/nginx)
- stripe integration
- create pdf for downloading
- badges
- track stats of how long a certification takes? that means updating cookie policy etc.
- become gdpr compliant, well need to store data first
- remove reference to pageant until we do the hardening certificate
- make many answers longer so that the right one isn't always the longest one!
- provide an instruction that allows the user to enter the hostname, not just it's ip address. add that to the ssh client page and refer to it on the nginx page.
- persistence for when answers are sent, IF the user is signed in
- fix budgets in angular.json -> 5.5 mb is WAY to big
- check we randomize the answers, not just the questions
- add copyright notices to the source files
- make abstracertification check things that are available online or get the user to paste things that it can verify that the user has actually done the work
- add links to other certifications on pages and at the end of a certification
  - show certification paths to becoming an abstratium professional
- create a markdown document in the docs folder to describe the certification modules that can be added to the webui/public folder which describes the way in which you can configure modules and their pages including all the options that exist. it should act as a specification for future engineers and LLMs.
- change lines like the following so that they use console.debug
  - `console.log('[DEBUG] choiceSelectionsChange:', selections);`
- move wizard which is in core back up to abstracore
- let user add notes
- let user supply feedback
- gamify the whole thing
- make LLM a paid feature, altho give a few cents of free credit to try it out. like X tokens and once they are used, they have to purchase something
- add i18n at a cost using an llm
- further modules
  - remote desktop on linux
  - security and hardening with optional remote internet access to the server.
    - fail2ban
    - disk encryption using abstravault
    - firewall
    - disable ping
    - ssh hardening including certificate based authentication
    - nginx rate limiting
    - etc.
  - wireguard vpn (peer to peer but as "client" and "server")
  - SSL with certbot from letsencrypt
    - including how to make it so that they are auto updated
  - move ai help to be part of the certification definition, not for the entire server. or "as well as"

- [ ] - Update SECURITY_DESIGN.md with project-specific information
- [ ] - Update SECURITY.md with project-specific information
- [ ] - Update `.windsurf` configuration

## FIXME

- **SECURITY_DESIGN.md**: File not found at `docs/security/SECURITY_DESIGN.md` — needs to be created or the link in README.md needs updating.
- **`.windsurf` configuration**: The `.windsurf/rules/` files may need project-specific updates (no TODOs found currently).
- **e2e-tests/pages/TODO.page.ts**: This file should be deleted — a replacement `certification.page.ts` has been created.




# TODO later after implementing your first feature

- remove all references to `demo` in the entire project
- remove all files with `demo` in their name
- add contact table (see migration script V01.014__) to GDPR management
- add user-certifications to GDPR management




## Tomorrow


## Later (not yet necessary for initial release)


