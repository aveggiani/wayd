LICENSE 
Copyright 2006 Paul Hastings

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

===   
Included in this archive are six versions of a CFC to handle java-style resource bundles (rb). The three major versions include:
- coreJava: If you don't need other calendars, locales, etc. offered by IBM's ICU4J library. This version uses core Java's Locale and MessageFormat classes. It will operate on any coldfusion host that permits createObject().
- icu4j: Requires the installation of IBM's ICU4J java library which can be obtained at http://www-306.ibm.com/software/globalization/icu/downloads.jsp#icu4j. This version uses the library installed on cf's classpath. It makes use of ICU4J's ULocale and MessageFormat classes. This allows for more locales than are supported by core Java as well as additional locale "keywords" such as calendar, currency and collation (for example, th_TH@calendar=buddhist).
- remoteICU4J: Also requires the installation of IBM's ICU4J java library which can be obtained at http://www-306.ibm.com/software/globalization/icu/downloads.jsp#icu4j. This version uses a slightly modified "remote" classpath technique (http://www.spike.org.uk/blog/index.cfm?do=blog.entry&entry=B49509DF-D565-E33F-31C9E574EA1591EE) for installations where you don't have access to the classpath. You will need to specify the full path to a copy of the icu4j.jar file.

In each of these versions you will find two CFCs:
- javaRB which handles rb files that aren't on the cf classpath (usually deployed on shared hosts).
- rbJava which uses rb files that are on the cf classpath, this is usually the more robust form of this tool.

You will also find:
- javaRB.cfm a simple testbed for the javaRB CFC
- rbJava.cfm a simple testbed for the rbJava CFC
- messageFormat.cfm a simple testbed demonstrating the messageFormat method.
- testJavaRB.properties base rb file
- testJavaRB_en_US.properties en_US locale rb file
- testJavaRB_th_TH.properties th_TH locale rb file

public methods in the CFCs:
- getResourceBundle returns a structure containing all key/messages value pairs in a given resource bundle file. required argument is rbFile containing absolute path to resource bundle file. optional argument is rbLocale to indicate which locale's resource bundle to use, defaults to us_EN (american english). PUBLIC
- getRBKeys returns an array holding all keys in given resource bundle. required argument is rbFile containing absolute path to resource bundle file. optional argument is rbLocale to indicate which locale's resource bundle to use, defaults to us_EN (american english). PUBLIC
- getRBString returns string containing the text for a given key in a given resource bundle. required arguments are rbFile containing absolute path to resource bundle file and rbKey a string holding the required key. optional argument is rbLocale to indicate which locale's resource bundle to use, defaults to us_EN (american english). PUBLIC
- formatRBString returns string w/dynamic values substituted. performs messageFormat like operation on compound rb string: "You owe me {1}. Please pay by {2} or I will be forced to shoot you with {3} bullets." this function will replace the place holders {1}, etc. with values from the passed in array (or a single value, if that's all there are). required arguments are rbString, the string containing the placeholders, and substitute. Values either an array or a single value containing the values to be substituted. note that the values are substituted sequentially, all {1} placeholders will be substituted using the first element in substitute. Values, {2} with the  second, etc. DEPRECATED. only retained for backwards compatibility. please use messageFormat method instead.
- messageFormat returns string w/dynamic values substituted. performs MessageFormat operation on compound rb string.  required arguments: pattern string to use as pattern for formatting, args array of "objects" to use as substitution values. optional argument is locale, java style locale ID, "th_TH", default is "en_US". for details about format options please see http://java.sun.com/j2se/1.4.2/docs/api/java/text/MessageFormat.html
- verifyPattern verifies MessageFormat pattern. required argument is pattern a string holding the MessageFormat pattern to test. returns a boolean indicating if the pattern is ok or not. PUBLIC	

In addition, the remoteICU4J CFCs also have another public method:
- getAvailableLocales returns an array of available locales. note that this method is only supplied as a convenience. PUBLIC

If you like, you can find my wishlist at 
http://www.amazon.com/gp/registry/wishlist/35SOQPL36CP87/104-4400936-8795966
	