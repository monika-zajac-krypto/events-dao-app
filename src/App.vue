<template>
  <v-app id="inspire">
    <v-app-bar app color="white" flat>
      <v-container class="py-0 fill-height">
        <div class="logo-container">
          <img class="logo" src="/img/events-dao-logo.png" />
          <h2>EventDAO</h2>
          <div class="powered-by-container">
            Powered by
            <a href="https://milkomeda.io" target="_blank">Milkomeda</a>
            <!-- 🚀 -->
          </div>
        </div>

        <v-btn
          v-for="topNavLink in topNavLinks"
          :key="topNavLink.text"
          :href="topNavLink.url"
          target="_blank"
          text
          class="mr-4"
        >
          <img class="top-nav-link-icon" :src="topNavLink.icon" />
          <span class="top-nav-link-text">{{ topNavLink.text }}</span>
        </v-btn>

        <v-spacer></v-spacer>

        <v-responsive max-width="260">
          <BlockchainAddress />
        </v-responsive>
      </v-container>
    </v-app-bar>

    <v-main class="grey lighten-3">
      <v-container>
        <v-row>
          <v-col cols="2">
            <v-sheet rounded="lg">
              <v-list color="transparent">
                <v-list-item link color="grey lighten-4">
                  <v-list-item-content>
                    <h3>Your DAOs</h3>
                  </v-list-item-content>
                </v-list-item>

                <v-divider class="my-2"></v-divider>

                <v-list-item
                  v-for="dao in daoList"
                  :key="dao.id"
                  link
                  :href="'/dao/' + dao.id"
                >
                  <v-list-item-content
                    :class="{ selected: dao.id === selectedDaoId }"
                  >
                    <v-list-item-title>
                      {{ dao.name }}
                    </v-list-item-title>
                  </v-list-item-content>
                </v-list-item>

                <v-divider class="my-2"></v-divider>

                <v-list-item
                  link
                  color="grey lighten-4"
                  @click="alert('Adding new DAOs will be implemented later')"
                >
                  <v-list-item-content>
                    <v-list-item-title> Add new DAO + </v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
            </v-sheet>
          </v-col>

          <v-col>
            <v-sheet min-height="70vh" rounded="lg">
              <div class="main-view">
                <div
                  v-if="displayGoBackLink"
                  @click="goBack()"
                  class="back-link"
                >
                  <v-icon style="position: relative; bottom: 1px">
                    mdi-chevron-left
                  </v-icon>
                  Back to DAO page
                </div>
                <router-view />
              </div>
            </v-sheet>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import BlockchainAddress from "./components/BlockchainAddress.vue";
import daosConfig from "./common/daos-config";

export default {
  data: () => ({
    links: ["Dashboard", "Messages", "Profile", "Updates"],
    topNavLinks: [
      {
        text: "Deck",
        url: "https://docs.google.com/presentation/d/1aeHR5ufr59QnnrmcJgQ4IN2EPbqq4Mc6MJRBVWYZLyk/edit#slide=id.g9baafe93df_0_397",
        icon: "/img/deck-icon.png",
      },
      {
        text: "Docs",
        url: "https://www.google.com/search?q=event+dao+docs",
        icon: "/img/docs-icon.png",
      },
      {
        text: "Twitter",
        url: "https://www.google.com/search?q=event+dao+twitter",
        icon: "/img/twitter-icon.png",
      },
      {
        text: "Discord",
        url: "https://www.google.com/search?q=event+dao+community",
        icon: "/img/discord-icon.png",
      },
      {
        text: "GitHub",
        url: "https://github.com/events-dao",
        icon: "/img/github-icon.png",
      },
    ],
    daoList: Object.entries(daosConfig).map(([id, name]) => ({ name, id })),
  }),
  components: {
    BlockchainAddress,
  },
  methods: {
    alert(msg) {
      this.$toast.open({
        message: msg,
        type: "success",
      });
    },
    goBack() {
      this.$router.push("/dao/" + this.selectedDaoId);
    },
  },
  computed: {
    selectedDaoId() {
      console.log(this.$route.params.id);
      return this.$route.params.id;
    },
    displayGoBackLink() {
      console.log(this.$router.currentRoute);
      return this.selectedDaoId && this.$router.currentRoute.name !== "dao";
    },
  },
};
</script>

<style scoped lang="scss">
.logo-container {
  height: 40px;
  display: flex;
  position: relative;
  margin-right: 50px;
  // border: 1px solid black;

  img {
    display: inline;
    height: 40px;
  }

  h2 {
    display: inline;
    position: relative;
    bottom: 1px;
    padding-left: 15px;
    padding-right: 15px;
    // border: 1px solid black;
  }

  .powered-by-container {
    font-size: 10px;
    position: absolute;
    bottom: -5px;
    left: 55px;
    width: 200px;
  }
}
.top-nav-link-icon {
  margin-right: 5px;
  height: 22px;
}
.top-nav-link-text {
  font-weight: 400;
  letter-spacing: normal !important;
  font-size: 16px;
  text-transform: capitalize !important;
}
.selected {
  font-weight: 500;
  border-top: 1.5px solid #4c8bf5;
  border-bottom: 1.5px solid #4c8bf5;
}
.back-link {
  position: absolute;
  top: 15px;
  left: 15px;
  font-size: 14px;
  transition: transform 0.3s;
  &:hover {
    transform: scale(1.1);
    cursor: pointer;
  }
}
</style>

<style lang="scss">
* {
  color: #444;
}

.main-view {
  position: relative;
  h2 {
    margin: auto;
    text-align: center;
    padding-top: 16px;
  }
}

.v-toast {
  font-family: Roboto, sans-serif;
}
</style>
