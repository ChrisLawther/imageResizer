SRCS=main.m NSImage+MGCropExtensions.m
OBJS=$(SRCS:.m=.o)

LDFLAGS=-framework AppKit
TARGET=imageResizer

all:	$(TARGET)

$(OBJS): %.o: %.m
	$(CC) -c $(CFLAGS) $< -o $@

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) $^ -o $@

.PHONY: clean
clean:
	rm -f $(OBJS) $(TARGET)

