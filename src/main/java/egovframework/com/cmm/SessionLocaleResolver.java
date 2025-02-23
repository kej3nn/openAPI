/*
 * Copyright 2002-2006 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package egovframework.com.cmm;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.i18n.AbstractLocaleResolver;
import org.springframework.web.util.WebUtils;

/**
 * Implementation of LocaleResolver that uses a locale attribute in the user's
 * session in case of a custom setting, with a fallback to the specified default
 * locale or the request's accept-header locale.
 *
 * <p>This is most appropriate if the application needs user sessions anyway,
 * that is, when the HttpSession does not have to be created for the locale.
 *
 * <p>Custom controllers can override the user's locale by calling
 * <code>setLocale</code>, e.g. responding to a locale change request.
 *
 * @author Juergen Hoeller
 * @see #setDefaultLocale
 * @see #setLocale
 * @since 27.02.2003
 */
public class SessionLocaleResolver extends AbstractLocaleResolver {

    /**
     * Name of the session attribute that holds the locale.
     * Only used internally by this implementation.
     * Use <code>RequestContext(Utils).getLocale()</code>
     * to retrieve the current locale in controllers or views.
     *
     * @see org.springframework.web.servlet.support.RequestContext#getLocale
     * @see org.springframework.web.servlet.support.RequestContextUtils#getLocale
     */
    public static final String LOCALE_SESSION_ATTRIBUTE_NAME = SessionLocaleResolver.class.getName() + ".LOCALE";

    private Locale locale;

    public Locale resolveLocale(HttpServletRequest request) {
        Locale locale = (Locale) WebUtils.getSessionAttribute(request, LOCALE_SESSION_ATTRIBUTE_NAME);
        if (locale == null) {
            locale = determineDefaultLocale(request);
            setLocale(locale);
        }
        return locale;
    }


    public Locale getLocale() {
        return locale;
    }

    public Locale getLocaleNew(HttpServletRequest request) {
        return (Locale) WebUtils.getSessionAttribute(request, LOCALE_SESSION_ATTRIBUTE_NAME);
    }

    public void setLocale(Locale locale) {
        this.locale = locale;
    }

    /**
     * Determine the default locale for the given request,
     * Called if no locale session attribute has been found.
     * <p>The default implementation returns the specified default locale,
     * if any, else falls back to the request's accept-header locale.
     *
     * @param request the request to resolve the locale for
     * @return the default locale (never <code>null</code>)
     * @see #setDefaultLocale
     * @see javax.servlet.http.HttpServletRequest#getLocale()
     */
    protected Locale determineDefaultLocale(HttpServletRequest request) {
        Locale defaultLocale = getDefaultLocale();
        if (defaultLocale == null) {
            defaultLocale = request.getLocale();
        }
        return defaultLocale;
    }

    public void setLocale(HttpServletRequest request, HttpServletResponse response, Locale locale) {
        //setLocale(locale);
        WebUtils.setSessionAttribute(request, LOCALE_SESSION_ATTRIBUTE_NAME, locale);
    }

}
