<template>
  <v-container>
    <v-row class="text-center">
      <v-col cols="12">
        <img class="big-logo" src="/img/events-dao-logo.png" height="140" />
      </v-col>

      <v-col class="mb-4">
        <h1 class="display-2 font-weight-bold mb-3">
          Welcome to the EventDAO 👋
        </h1>

        <p class="subheading font-weight-regular">
          ⬅️ Select a DAO from the list to start ⬅️
        </p>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: "Welcome",
};
</script>

<style lang="scss" scoped>
.big-logo {
  margin-top: 50px;
}
</style>
