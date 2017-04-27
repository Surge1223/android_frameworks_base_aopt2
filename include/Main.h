//
// Copyright 2006 The Android Open Source Project
//
// Some global defines that don't really merit their own header.
//
#ifndef __MAIN_H
#define __MAIN_H

#include "util/StringPiece.h"

#include <utils/Log.h>
#include <utils/threads.h>
#include <utils/List.h>
#include <utils/Errors.h>
#include <utils/StrongPointer.h>

namespace aapt {
extern int compile(const std::vector<StringPiece>& args);
extern int link(const std::vector<StringPiece>& args);
extern int dump(const std::vector<StringPiece>& args);
extern int diff(const std::vector<StringPiece>& args);
}
#endif // __MAIN_H
