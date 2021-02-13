#pragma once

#include "natalie/forward.hpp"

namespace Natalie {

struct ValuePtr {
    ValuePtr() { }

    ValuePtr(Value *value)
        : m_value { value } { }

    Value &operator*() { return *m_value; }
    Value *operator->() { return m_value; }
    Value *value() { return m_value; }

    bool operator==(Value *other) { return m_value == other; }
    bool operator!=(Value *other) { return m_value != other; }
    bool operator!() { return !m_value; }
    operator bool() { return !!m_value; }

    ValuePtr send(Env *, SymbolValue *, size_t = 0, ValuePtr * = nullptr, Block * = nullptr);
    ValuePtr send(Env *, const char *, size_t = 0, ValuePtr * = nullptr, Block * = nullptr);
    ValuePtr send(Env *, size_t, ValuePtr *, Block *);

private:
    Value *m_value { nullptr };
};

}
