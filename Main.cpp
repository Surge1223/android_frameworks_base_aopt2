/*
 * Copyright (C) 2015 The Android Open Source Project
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

#include "util/StringPiece.h"

#include <Flags.h>
#include <AppInfo.h>
#include <ConfigDescription.h>
#include <Debug.h>
#include <Diagnostics.h>
#include <Locale.h>
#include <NameMangler.h>
#include <Resource.h>
#include <ResourceParser.h>
#include <ResourceTable.h>
#include <ResourceUtils.h>
#include <ResourceValues.h>
#include <SdkConstants.h>
#include <Source.h>
#include <StringPool.h>
#include <ValueVisitor.h>
#include <algorithm>
#include <androidfw/AssetManager.h>
#include <cstdlib>
#include <dirent.h>
#include <errno.h>
#include <fstream>
#include <iostream>
#include <sstream>
#include <sys/stat.h>
#include <unordered_set>
#include <utils/Errors.h>
#include <vector>
#include <Main.h>

#ifndef AOPT_VERSION
#define AOPT_VERSION ""
#endif

constexpr const char* kAaptVersionStr = "Android Overlay Packaging Tool, v2-" AOPT_VERSION "";
extern int compile(const std::vector<aapt::StringPiece>& args);
extern int link(const std::vector<aapt::StringPiece>& args);
extern int dump(const std::vector<aapt::StringPiece>& args);
extern int diff(const std::vector<aapt::StringPiece>& args);

using namespace aapt;



struct AaptOptions {
    enum class Phase {
        Link,
        Compile,
        Dump,
        Diff,
    };

    enum class PackageType {
        StandardApp,
        StaticLibrary,
    };

        // The phase to process.
    Phase phase;

        // The type of package to produce.
    PackageType packageType = PackageType::StandardApp;

        // Details about the app.
    AppInfo appInfo;

        // The location of the manifest file.
    Source manifest;

        // The APK files to link.
    std::vector<Source> input;

        // The libraries these files may reference.
    std::vector<Source> libraries;

        // Output path. This can be a directory or file
        // depending on the phase.
    Source output;

        // Directory in which to write binding xml files.
    Source bindingOutput;

        // Directory to in which to generate R.java.
    Maybe<Source> generateJavaClass;

        // File in which to produce proguard rules.
    Maybe<Source> generateProguardRules;

        // Whether to output verbose details about
        // compilation.
    bool verbose = false;

        // Whether or not to auto-version styles or layouts
        // referencing attributes defined in a newer SDK
        // level than the style or layout is defined for.
    bool versionStylesAndLayouts = true;

        // The target style that will have it's style hierarchy dumped
        // when the phase is DumpStyleGraph.
    ResourceName dumpStyleTarget;
};



static void printCommands() {
    std::cerr << "================================================= " << std::endl << std::endl;
    std::cerr << "	Android Overlay Packaging Tool v2           " << std::endl << std::endl;
    std::cerr << "=================================================  " << std::endl << std::endl;
    std::cerr << " No arguments provided                             " << std::endl << std::endl;
    std::cerr << " The following commands are supported:             " << std::endl << std::endl;
    std::cerr << std::endl;
    std::cerr << "c   compile   compiles a subset of resources      " << std::endl;
    std::cerr << "l   link      links compiled resources and libs   " << std::endl;
    std::cerr << "df  diff      diff of two apk files specifyc dump " << std::endl;
    std::cerr << "d   dump      dumps resource contents to stdout   " << std::endl;
    std::cerr << std::endl;
    std::cerr << "run aopt2 with arg and -h flag for extra details  " << std::endl;
    std::cerr << std::endl;
}


int main(int argc, char** argv) {
    std::vector<aapt::StringPiece> args;

    if (argc >= 2) {
        argv += 1;
        argc -= 1;


/*        std::vector<aapt::StringPiece> args;
        for (int i = 1; i < argc; i++) {
            args.push_back(argv[i]);
        }
*/
        for (int i = 1; i < argc; i++) {
            args.push_back(argv[i]);
        }
    }
    const StringPiece command(argv[0]);
    AaptOptions options;
    Flags flags = Flags();

    if (command == "--version" || command == "version") {
        std::cout << kAaptVersionStr << std::endl;
        exit(0);
    } else if (command == "--help" || command == "help") {
        printCommands();
    } else if (command == "link" || command == "l") {
        options.phase = AaptOptions::Phase::Link;
    } else if (command == "compile" || command == "c") {
        options.phase = AaptOptions::Phase::Compile;
    } else if (command == "dump" || command == "d") {
        options.phase = AaptOptions::Phase::Dump;
    } else if (command == "diff" || command == "df") {
        options.phase = AaptOptions::Phase::Diff;
    } else if (command == "v" || command == "version" || command == "-v") {
        std::cout << kAaptVersionStr << std::endl;
        exit(0);
    } else {
        printCommands();
        std::cerr << "unknown command '" << command << "'\n";
    }

    bool isStaticLib = false;

        // Build the command string for output (eg. "aopt2 compile").
    std::string fullCommand = "aopt2";
    fullCommand += " ";
    fullCommand += command.toString();

        // Actually read the command line flags.

    if (isStaticLib) {
        options.packageType = AaptOptions::PackageType::StaticLibrary;
    }

    if (options.phase == AaptOptions::Phase::Dump) {
        return aapt::dump(args);
    } else if (options.phase == AaptOptions::Phase::Compile) {
        return aapt::compile(args);
    } else if (options.phase == AaptOptions::Phase::Diff) {
        return aapt::diff(args);
    } else if (options.phase == AaptOptions::Phase::Link) {
	return aapt::link(args);
    }

    return 1;
}
