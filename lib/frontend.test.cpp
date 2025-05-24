#include "frontend.h"
#include <gtest/gtest.h>

TEST(NewInputBufferTest, InitializesFieldsToZeroOrNull) {
  InputBuffer* input_buffer = new_input_buffer();

  ASSERT_NE(input_buffer, nullptr);
  EXPECT_EQ(input_buffer->buffer, nullptr);
  EXPECT_EQ(input_buffer->buffer_length, 0u);
  EXPECT_EQ(input_buffer->input_length, 0);

  free(input_buffer);
}

TEST(NewInputBufferTest, AllocatesDistinctInstances) {
  InputBuffer* buf1 = new_input_buffer();
  InputBuffer* buf2 = new_input_buffer();

  ASSERT_NE(buf1, nullptr);
  ASSERT_NE(buf2, nullptr);
  EXPECT_NE(buf1, buf2);

  free(buf1);
  free(buf2);
}
