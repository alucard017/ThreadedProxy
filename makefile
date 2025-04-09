# Makefile for HTTP Proxy Server

# Compiler
CXX = g++

# Compiler flags
CXXFLAGS = -std=c++17 -Wall -Wextra -pedantic

# Linker flags
LDFLAGS = -lpthread

#Include directories
INCLUDES = -Iserver -Icache -Ipool -Iutils -Iparser

# Source files
CPP_SOURCES = main.cpp \
 server/ServerFactory.cpp \
 server/ThreadPoolServer.cpp \
 server/SemaphoreServer.cpp \
 cache/LRUCache.cpp \
 cache/LFUCache.cpp \
 pool/ThreadPool.cpp \
 utils/ProxyUtils.cpp \

C_SOURCES = parser/proxy_parse.c

# Object files
OBJECTS = $(CPP_SOURCES:.cpp=.o) $(C_SOURCES:.c=.o)


# Executable name
EXECUTABLE = proxy_server

# Default target
all: $(EXECUTABLE)

# Rule to create the executable
$(EXECUTABLE): $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ $^ $(LDFLAGS)

# Rule to compile source files to object files
%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

# Clean target
clean:
	rm -f $(OBJECTS) $(EXECUTABLE)

# Phony targets
.PHONY: all clean

# Dependencies
main.o: main.cpp server/ServerFactory.hpp server/HTTPServer.hpp
LRUCache.o: LRUCache.cpp LRUCache.hpp CacheStrategy.hpp
LFUCache.o: LFUCache.cpp LFUCache.hpp CacheStrategy.hpp
ServerFactory.o: ServerFactory.cpp ServerFactory.hpp ThreadPoolServer.hpp SemaphoreServer.hpp LRUCache.hpp LFUCache.hpp
ThreadPoolServer.o: ThreadPoolServer.cpp ThreadPoolServer.hpp HTTPServer.hpp ThreadPool.hpp ProxyUtils.hpp proxy_parse.h
SemaphoreServer.o: SemaphoreServer.cpp SemaphoreServer.hpp HTTPServer.hpp ProxyUtils.hpp proxy_parse.h
ThreadPool.o: ThreadPool.cpp ThreadPool.hpp
ProxyUtils.o: ProxyUtils.cpp ProxyUtils.hpp proxy_parse.h
proxy_parse.o: proxy_parse.c proxy_parse.h
	gcc -std=c11 -Wall -Wextra -pedantic -c proxy_parse.c -o proxy_parse.o