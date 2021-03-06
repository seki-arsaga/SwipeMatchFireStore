/*
 * Copyright 2019 Google
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

#ifndef FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_UTIL_OBJC_COMPATIBILITY_H_
#define FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_UTIL_OBJC_COMPATIBILITY_H_

#if !defined(__OBJC__)
#error "This header only supports Objective-C++"
#endif  // !defined(__OBJC__)

#import <Foundation/Foundation.h>

#include <algorithm>
#include <string>
#include <type_traits>

#include "Firestore/core/src/firebase/firestore/util/string_apple.h"
#include "Firestore/core/src/firebase/firestore/util/to_string.h"
#include "Firestore/core/src/firebase/firestore/util/type_traits.h"
#include "absl/meta/type_traits.h"

/**
 * Utility functions that help C++ code interoperate with Objective-C while
 * migration is in progress
 */

namespace firebase {
namespace firestore {
namespace util {
namespace objc {

namespace internal {

template <typename T>
using is_container_of_objc =
    absl::conjunction<is_iterable<T>,
                      is_objective_c_pointer<typename T::value_type>>;

}

/**
 * Checks two Objective-C objects for equality using `isEqual`. Two nil objects
 * are considered equal, unlike the behavior of `isEqual`.
 */
template <typename T,
          typename = absl::enable_if_t<is_objective_c_pointer<T*>::value>>
bool Equals(T* lhs, T* rhs) {
  return (lhs == nil && rhs == nil) || [lhs isEqual:rhs];
}

/** Checks two C++ containers of Objective-C objects for "deep" equality. */
template <
    typename T,
    typename = absl::enable_if_t<internal::is_container_of_objc<T>::value>>
bool Equals(const T& lhs, const T& rhs) {
  using Ptr = typename T::value_type;

  return lhs.size() == rhs.size() &&
         std::equal(lhs.begin(), lhs.end(), rhs.begin(),
                    [](Ptr o1, Ptr o2) { return Equals(o1, o2); });
}

/**
 * Creates a debug description of the given `value` by calling `ToString` on it,
 * converting the result to an `NSString`. Exists mainly to simplify writing
 * `description:` methods for Objective-C classes.
 */
template <typename T>
NSString* Description(const T& value) {
  return WrapNSString(ToString(value));
}

}  // namespace objc
}  // namespace util
}  // namespace firestore
}  // namespace firebase

#endif  // FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_UTIL_OBJC_COMPATIBILITY_H_
