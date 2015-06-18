SRCS=main.m NSImage+MGCropExtensions.m
OBJS=$(SRCS:.m=.o)

LDFLAGS=-framework AppKit
TARGET=imageResizer
MG_URL=http://mattgemmell.com/files/source/imagecrop.tgz
MGCROP=NSImage+MGCropExtensions.m

all: $(MGCROP) $(TARGET)

$(MGCROP):
	curl $(MG_URL) | tar -zxv --strip=1 ImageCropDemo/NSImage+MGCropExtensions.{m,h}
	
$(OBJS): %.o: %.m
	$(CC) -c $(CFLAGS) $< -o $@

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) $^ -o $@

.PHONY: clean
clean:
	rm -f $(OBJS) $(TARGET)

