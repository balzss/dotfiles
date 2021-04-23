#!/bin/sh

#define parameters which are passed in.
NAME=$1

#define the filename and the template.
cat > "$NAME.js" << EOF
import React from 'react';

export default function $NAME() {
  return (
    <div>
      <h1>Hello $NAME</h1>
    </div>
  );
}
EOF
